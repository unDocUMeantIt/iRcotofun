# Copyright 2015 Meik Michalke <meik.michalke@hhu.de>
#
# This file is part of the R package iRcotofun.
#
# iRcotofun is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# iRcotofun is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with iRcotofun.  If not, see <http://www.gnu.org/licenses/>.

#' Create a quiz
#' 
#' Creates an object of class \code{\link[XiMpLe:XiMpLe.doc-class]{XiMpLe.doc}},
#' which in this case is an HTML document that can be written to a single file
#' and opened in a web browser to get a quiz.
#' 
#' All categories must have the same number of items, and this number must also
#' be identical to the values given as \code{points}.
#' Also, if you use images, make sure that paths are valid.
#' 
#' @param ... Objects of class \code{\link[iRcotofun:iRc_category-class]{iRc_category}}.
#' @param points A numeric vector defining the points for each item in
#'    all catgories. 
#' @param file Character string, path to a file to write to.
#' @param title Character string, title of the quiz.
#' @param sound Character string, name of the sound file to use for background (if available).
#' @param css Character string, path to a custom CSS file if you don't want to use the default.
#' @param overwrite Logical, whether existing files should be overwritten. Otherwise an error is thrown.
#' @param questions Logical, whether the questions should be shown (quiz style) or the answers (jeopardy style, default).
#' @return An object of class \code{XiMpLe.doc}, or (if \code{file} is specified) no visible
#'    return value.
#' @rdname ircotofun
#' @export
#' @examples
#' q1 <- ask(
#'   question=list(text="What is Crichton's nick name for Chiana?"),
#'   answer=list(html=strong("Pip"))
#' )
#' q2 <- ask(
#'   question=list(text="What is Crichton's nick name for his gun?"),
#'   answer=list(html=strong("Winona"))
#' )
#' q3 <- ask(
#'   question=list(text="What is a famous quote from Rygel?"),
#'   answer=list(html=strong("Hail, prince of the obvious!"))
#' )
#' q4 <- ask(
#'   question=list(text="What is the Nebari Resistance fighting against?"),
#'   answer=list(html=strong("The Establishment"))
#' )
#'
#' # make a category
#' farscape <- category(name="Farscape", q1, q2, q3, q4)
#' 
#' # for the sake of demonstration, we'll create a quiz that shows
#' # the same category four times...
#' \dontrun{
#' (output <- tempfile(fileext=".html"))
#' ircotofun(
#'   farscape,
#'   farscape,
#'   farscape,
#'   farscape,
#'   points=c(100,200,300,400),
#'   file=output,
#'   title="Best Science Fiction Shows Ever"
#' )
#' }

ircotofun <- function(..., points, file=NULL, title="iRcotofun", sound=NULL, css=NULL, overwrite=FALSE, questions=FALSE){
  if(!is.numeric(points)){
    stop(simpleError(paste0("\"points\" must be a numeric vector, but is of class \"", class(points), "\"!")))
  } else {
    numPoints <- length(points)
  }

  if(isTRUE(questions)){
    qStyle <- ""
    aStyle <- "display:none;"
  } else {
    qStyle <- "display:none;"
    aStyle <- ""
  }
  
  colors <- c("rot", "gruen", "gelb", "blau")
  lightcolors <- c("LightPink", "LightGreen", "Gold", "LightSkyBlue")
  
  ## head
  iRcPath <- installed.packages()["iRcotofun", "LibPath"]
  if(is.null(css)){
    css <- file.path(iRcPath, "iRcotofun", "files", "ircotofun.css")
    if(!file.exists(css)){
      stop(simpleError("Can't find 'ircotofun.css' CSS file! Is you installation ok?"))
    } else {}
  } else {}
  fullCSS <- paste0(readLines(css), collapse="\n")
  javascript <- file.path(iRcPath, "iRcotofun", "files", "ircotofun.js")
  javascript_nosound <- file.path(iRcPath, "iRcotofun", "files", "ircotofun_nosound.js")
  javascript_sound <- file.path(iRcPath, "iRcotofun", "files", "ircotofun_sound.js")
  if(!file.exists(javascript) | !file.exists(javascript_nosound) | !file.exists(javascript_sound)){
    stop(simpleError("Can't find JavaScript file! Is you installation ok?"))
  } else {}
  fullJS <- paste0(readLines(javascript), collapse="\n")
  fullJS_nosound <- paste0(readLines(javascript_nosound), collapse="\n")
  fullJS_sound <- paste0(readLines(javascript_sound), collapse="\n")
  head <- XMLNode("head",
    XMLNode("title", title),
    XMLNode("style", fullCSS, attrs=list(type="text/css")),
    if(is.null(sound)){
      XMLNode("script", fullJS_nosound, attrs=list(type="text/javascript"))
    } else {
      XMLNode("script", fullJS_sound, attrs=list(type="text/javascript"))
    },
    XMLNode("script", fullJS, attrs=list(type="text/javascript"))
  )

  fullHTML <- list()

  ## categories
  categories <- list(...)
  numCats <- length(categories)
  tableColWidth <- 70/numCats
  tableRowHeight <- 100/(numPoints + 1)
  for (thisCatNum in 1:numCats){
    thisCategory <- categories[[thisCatNum]]
    if(!inherits(thisCategory, "iRc_category")){
      stop(simpleError(paste0("All values given via \"...\" must be of class \"iRc_category\", but got \"", class(thisCategory), "\"!")))
    } else {
      thisCatName <- slot(thisCategory, "name")
      thisCatItems <- slot(thisCategory, "items")
      if(length(thisCatItems) != length(points)){
        stop(simpleError(paste0("All categories must have as many items as \"points\" (", length(points),
          "), but \"", thisCatName, "\" has ", length(thisCatItems), "!")))
      } else {}
      # category names
      posFromLeft <- (thisCatNum - 1) * tableColWidth + 15
      thisCatTableName <- span(attrs=list(
          class="kopfzeile",
          style=paste0("position: absolute; left: ", posFromLeft, "%; top: 0%; width: ", tableColWidth,"%; height: ", tableRowHeight,"%;")
        ),
        table_(attrs=list(class="zelle"),
          tbody(
            tr(
              th(attrs=list(class="roundborders"), thisCatName)
            )
          )
        )
      )
      fullHTML <- append(fullHTML, thisCatTableName)
    }
  }

  # points
  for (thisPoint in 1:numPoints){
    posFromTop <- (thisPoint -1 ) * (100 / (numPoints + 1)) + (100 / (numPoints + 1))
    for (thisCatNum in 1:numCats){
      posFromLeft <- (thisCatNum - 1) * (70 / numCats) + 15
      thisPointValue <- span(attrs=list(
          id=paste0("r",thisPoint,"c",thisCatNum,"cat"),
          class="cat largefont",
          style=paste0("position: absolute; left: ", posFromLeft, "%; top: ", posFromTop, "%; width: ", tableColWidth,"%; height: ", tableRowHeight,"%;")
        ),
        table_(attrs=list(class="zelle"),
          tbody(
            tr(
              td(attrs=list(class="zellenrand roundborders cat hugefont"),
                a(attrs=list(
                    onclick=paste0(
                      "javascript:qachange('r",thisPoint,"c",thisCatNum,"off',",
                      "'r",thisPoint,"c",thisCatNum,"cat','fragantwtabr",thisPoint,"c",thisCatNum,"',",
                      if(isTRUE(questions)){
                        paste0("'showar",thisPoint,"c",thisCatNum,"','showqr",thisPoint,"c",thisCatNum,"',")
                      } else {
                        paste0("'showqr",thisPoint,"c",thisCatNum,"','showar",thisPoint,"c",thisCatNum,"',")
                      },
                      paste0("'", paste0("namer",thisPoint,"c",thisCatNum, colors, collapse="','"), "')")
                    ),
                    href="#"
                  ),
                  as.character(points[thisPoint])
                )         
              )
            )
          )
        )
      )
      fullHTML <- append(fullHTML, thisPointValue)
      thisPointOff <- span(
        table_(
          tbody(
            tr(
              td(
                "&nbsp;",
                attrs=list(class="celloffbottom")
              ),
              attrs=list(class="celloffbottom")
            ),
            tr(
              td(
                span(
                  as.character(points[thisPoint]),
                  attrs=list(class=" zellenrandoff", id=paste0("r",thisPoint,"c",thisCatNum,"valueoff"))
                ),
                attrs=list(class="cellofftop zellenrandoff roundborders cat hugefont")
              ),
              attrs=list(class="cellofftop")
            ),
            tr(
              td(
                a(
                  "&#9851;",
                  attrs=list(
                    title="Re-enable Item",
                    class="reenable",
                    onclick=paste0(
                      "javascript:reset('r",thisPoint,"c",thisCatNum,"cat','r",thisPoint,"c",thisCatNum,"off',",
                      if(isTRUE(questions)){
                        paste0("'antwortr",thisPoint,"c",thisCatNum,"','frager",thisPoint,"c",thisCatNum,"'")
                      } else {
                        paste0("'frager",thisPoint,"c",thisCatNum,"','antwortr",thisPoint,"c",thisCatNum,"'")
                      },
                      paste0(sapply(1:length(colors),
                        function(colnum){
                          paste0(",'tdpointsr",thisPoint,"c",thisCatNum,colors[colnum],"','tdgnamer",thisPoint,"c",thisCatNum,colors[colnum],"'")
                        }
                      ), collapse=""),
                      ")" 
                    ),
                    href="#")
                ),
                attrs=list(class="zellenrandoff celloffbottom roundborders")
              ),
              attrs=list(class="celloffbottom")
            )
          ),
          attrs=list(class="zelle")
        ),
        attrs=list(
          id=paste0("r",thisPoint,"c",thisCatNum,"off"),
          class="off largefont",
          style=paste0("position: absolute; left: ", posFromLeft, "%; top: ", posFromTop, "%; width: ", tableColWidth,"%; height: ", tableRowHeight,"%;")
        )
      )
      fullHTML <- append(fullHTML, thisPointOff)
    }
  }

  # values
  for (thisCatNum in 1:numCats){
    thisCategory <- categories[[thisCatNum]]
    thisCatName <- slot(thisCategory, "name")
    thisCatItems <- slot(thisCategory, "items")
    for (thisItemNum in 1:numPoints){
      thisCatItemValues <- div(
        # category name
        span(
          table_(
            tbody(
              tr(
                td(
                  thisCatName,
                  attrs=list(class="fragekopf largefont", colspan="4")
                ),
                attrs=list(class="roundborders")
              )
            ),
            attrs=list(class="fragekopf")
          ),
          attrs=list(class="fragekopfspan")
        ),
        # questions and answers
        span(
          table_(
            tbody(
              tr(
                td(
                  # questions
                  span(
                    sapply(1:length(slot(thisCatItems[[thisItemNum]], "question")),
                      function(thisItemPartNum){
                        return(
                          pasteItem(
                            item=slot(thisCatItems[[thisItemNum]], "question")[[thisItemPartNum]],
                            name=names(slot(thisCatItems[[thisItemNum]], "question"))[[thisItemPartNum]],
                            category=thisCatName,
                            points=as.character(points[thisItemNum]),
                            missing="(no question)"
                          )
                        )
                      }
                    ),
                    attrs=list(id=paste0("frager",thisItemNum,"c",thisCatNum), style=qStyle)
                  ),
                  # answers
                  span(
                    sapply(1:length(slot(thisCatItems[[thisItemNum]], "answer")),
                      function(thisItemPartNum){
                        return(
                          pasteItem(
                            item=slot(thisCatItems[[thisItemNum]], "answer")[[thisItemPartNum]],
                            name=names(slot(thisCatItems[[thisItemNum]], "answer"))[[thisItemPartNum]],
                            category=thisCatName,
                            points=as.character(points[thisItemNum]),
                            missing="(no answer)"
                          )
                        )
                      }
                    ),
                    attrs=list(id=paste0("antwortr",thisItemNum,"c",thisCatNum), style=aStyle)
                  ),
                  attrs=list(class="fragekoerper normalfont", colspan="4")
                )
              )
            ),
            attrs=list(class="fragekoerper")
          ),
          attrs=list(class="fragekoerperspan")
        ),
        # foot q&a
        span(
          table_(
            tbody(
              tr(
                td(
                  a(
                    "show question",
                    attrs=list(
                      onclick=paste0("javascript:replace('frager",thisItemNum,"c",thisCatNum,"','antwortr",thisItemNum,"c",thisCatNum,"','showar",thisItemNum,"c",thisCatNum,"','showqr",thisItemNum,"c",thisCatNum,"')"),
                      href="#",
                      id=paste0("showqr",thisItemNum,"c",thisCatNum)
                    )
                  ),
                  "&bull;",
                  a(
                    "cancel",
                    attrs=list(onclick=paste0("javascript:antwortaus('fragantwtabr",thisItemNum,"c",thisCatNum,"')"), href="#")
                  ),
                  "&bull;",
                  a(
                    "show answer",
                    attrs=list(
                      onclick=paste0("javascript:replace('antwortr",thisItemNum,"c",thisCatNum,"','frager",thisItemNum,"c",thisCatNum,"','showqr",thisItemNum,"c",thisCatNum,"','showar",thisItemNum,"c",thisCatNum,"')"),
                      href="#",
                      id=paste0("showar",thisItemNum,"c",thisCatNum)
                    )
                  ),
                  attrs=list(class="fragefuss smallfont", colspan="4")
                )
              )
            ),
            attrs=list(class="fragefuss")
          ),
          attrs=list(class="fragefussspan")
        ),
        # foot points
        span(
          table_(
            tbody(
              tr(
                sapply(1:length(colors),
                  function(colnum){
                    td(
                      a(
                        as.character(points[thisItemNum]),
                        attrs=list(
                          class=paste0(colors[colnum], " largefont"),
                          onclick=paste0("javascript:points('fragantwtabr",thisItemNum,"c",thisCatNum,"','punkte",colors[colnum],"','",
                            as.character(points[thisItemNum]), "','r",thisItemNum,"c",thisCatNum,"valueoff','",lightcolors[colnum],"','punkte",colors[colnum],"')"),
                          href="#"
                        )
                      ),
                      br(),
                      a(
                        paste0("-", as.character(points[thisItemNum])),
                        attrs=list(
                          class=paste0(colors[colnum], " smallfont"),
                          onclick=paste0("javascript:wrong('punkte",colors[colnum],"','", as.character(points[thisItemNum]),
                          "','tdpointsr",thisItemNum,"c",thisCatNum,colors[colnum],"','tdgnamer",thisItemNum,"c",thisCatNum,colors[colnum],"')"),
                          href="#"
                        )
                      ),
                      attrs=list(
                        id=paste0("tdpointsr",thisItemNum,"c",thisCatNum,colors[colnum]),
                        class=paste0(colors[colnum], " fragefuss punktbutton roundborders")
                      )
                    )
                  }
                )
              )
            ),
            attrs=list(class="fragefuss")
          ),
          attrs=list(class="fragepunktspan")
        ),
        # foot group names
        span(
          table_(
            tbody(
              tr(
                sapply(1:length(colors),
                  function(colnum){
                    td(
                      XMLNode("input",
                        attrs=list(
                          id=paste0("namer",thisItemNum,"c",thisCatNum, colors[colnum]),
                          class=paste0(colors[colnum], " puenktskes smallfont"),
                          type="text",
                          size="5",
                          readonly=""
                        )
                      ),
                      attrs=list(
                        id=paste0("tdgnamer",thisItemNum,"c",thisCatNum,colors[colnum]),
                        class=paste0(colors[colnum], " fragefuss punktbutton smallfont roundborders")
                      )
                    )
                  }
                )
              )
            ),
            attrs=list(class="fragefuss")
          ),
          attrs=list(class="fragegruppenspan")
        ),
        # attributes for the main <div>
        attrs=list(
          id=paste0("fragantwtabr",thisItemNum,"c",thisCatNum),
          class="frage"
        )
      )
      fullHTML <- append(fullHTML, thisCatItemValues)
    }
  }
  ## groups
  for (thisGroup in colors){
    fullHTML <- append(fullHTML,
      span(
        table_(
          tbody(
            tr(
              td(
                XMLNode("input",
                  attrs=list(
                    id=paste0("punkte", thisGroup),
                    class=paste0(thisGroup, " puenktskes largefont"),
                    type="text",
                    size="5",
                    value="0"
                  )
                ),
                attrs=list(
                  class=paste0(thisGroup, " roundborders")
                )
              )
            )
          ),
          attrs=list(class="zelle")
        ),
        attrs=list(
          id=paste0("erg", thisGroup),
          class=paste0("erg", thisGroup)
        )
      )
    )
    # group names
    fullHTML <- append(fullHTML,
      span(
        table_(
          tbody(
            tr(
              td(
                XMLNode("input",
                  attrs=list(
                    id=paste0("name", thisGroup),
                    class=paste0(thisGroup, " puenktskes smallerfont"),
                    type="text",
                    size="12",
                    value=paste0("&lt;team ",thisGroup,"&gt;"),
                    onblur=paste0("javascript:if(this.value=='')this.value='&lt;team ",thisGroup,"&gt;';"),
                    onfocus=paste0("javascript:if(this.value=='&lt;team ",thisGroup,"&gt;')this.value='';")
                  )
                ),
                attrs=list(class=paste0(thisGroup, " roundborders"))
              )
            )
          ),
          attrs=list(class="zelle")
        ),
        attrs=list(
          id=paste0("namespan", thisGroup),
          class=paste0("name", thisGroup)
        )
      )
    )
  }

  ## random group select
  fullHTML <- append(fullHTML,
    span(
      a(
        attrs=list(
          class="random",
          onclick="javascript:blinkrandom()",
          title="randomly pick a team!",
          href="#"
        ),
        "&orarr;"
      ),
      attrs=list(
        class="random",
        id="randomgroup"
      )
    )
  )
  
  ## sound
  if(!is.null(sound)){
      if(file.exists(sound)){
      sound64 <- base64encode(sound, linewidth=80, newline="\n")
      # try to set the audio type
      if(grepl("wav$", sound, ignore.case=TRUE)){
        soundType <- "wav"
      } else if(grepl("mp3$|mpeg$", sound, ignore.case=TRUE)) {
        soundType <- "mpeg"
      } else if(grepl("ogg$", sound, ignore.case=TRUE)) {
        soundType <- "ogg"
      } else if(grepl("opus$", sound, ignore.case=TRUE)) {
        soundType <- "opus"
      } else if(grepl("flac$", sound, ignore.case=TRUE)) {
        soundType <- "flac"
      } else {
        warning(
          paste0("Cannot detect audio type, please covert into *.opus, *.ogg, *.flac, *.wav, or *.mp3 if there are problems:\n  ", sound)
        )
        soundType <- "wav"
      }
      bgAudio <- XMLNode("audio",
        attrs=list(
          src=paste0("data:audio/", soundType, ";base64,", sound64)
        )
      )
      fullHTML <- append(fullHTML, bgAudio)
    } else {
      stop(simpleError(paste0(
        "The following file cannot be found:\n  ", sound
      )))
    }
  } else {}

  fullHTML <- XMLNode("html",
    head,
    XMLNode("body", .children=fullHTML)
  )
  fullHTML <- XMLTree(fullHTML)

  if(is.null(file)){
    return(fullHTML)
  } else {
    if((file.exists(file) & isTRUE(overwrite)) | !file.exists(file)){
      cat(pasteXMLTree(fullHTML), file=file)
      return(invisible(NULL))
    } else {
      stop(simpleError("file already exists!"))
    }
  }
}

# internal helper function to write questions/answers
pasteItem <- function(item, name, category, points, missing="(no question)"){
  if(identical(name, "img")){
    if(file.exists(item)){
      img64 <- base64encode(item, linewidth=80, newline="\n")
      # try to set the image type
      if(grepl("png$", item, ignore.case=TRUE)){
        imgType <- "png"
      } else if(grepl("jpg$|jpeg$", item, ignore.case=TRUE)) {
        imgType <- "jpeg"
      } else if(grepl("gif$", item, ignore.case=TRUE)) {
        imgType <- "gif"
      } else {
        warning(
          paste0("Cannot detect image type, please covert into *.png, *.jpg or *.gif if there are problems:\n  ", item)
        )
        imgType <- "bmp"
      }
      return(
        div(
          XMLNode("img",
            attrs=list(
              class="image",
              src=paste0("data:image/", imgType, ";base64,", img64),
              alt=paste0(category, " :: ", points))
          ),
          attrs=list(class="imagediv")
        )
      )
    } else {
      stop(simpleError(paste0(
        "The following file cannot be found:\n  ", item
      )))
    }
  } else if(identical(name, "text")){
    return(item)
  } else if(identical(name, "html")){
    return(item)
  } else {
    return(missing)
  }
}
