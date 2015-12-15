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

#' Generate a title page
#' 
#' In case you would like to show off with a huge show, use this function to generate a title page
#' that plays some intro music, before you open the actual quiz.
#' 
#' @note: You should encode images etc. with \code{\link[base64enc:base64enc]{base64enc}} like
#' shown in the example, to ensure they are embedded into the HTML file. This keeps your presentation
#' from breaking if you move it somewhere else. It will work with ordinary file paths as well, as
#' long as all files remain in place.
#' 
#' @param ... Objects of class \code{\link[XiMpLe:XiMpLe.node-class]{XiMpLe.node}}, the page content.
#' @param quizfile Character string, full path to the actual quiz file. The resulting title page will
#'    use a relative link if both files are in the same directory, so it's easy to move both afterwards.
#' @param file Character string, path to a file to write to.
#' @param title Character string, used as the window title.
#' @param sound Character string, name of the sound file to use for automatic background (if available).
#' @param css Character string, path to a custom CSS file if you don't want to use the default.
#' @param overwrite Logical, whether existing files should be overwritten. Otherwise an error is thrown.
#' @return An object of class \code{XiMpLe.doc}, or (if \code{file} is specified) no visible
#'    return value.
#' @rdname titlepage
#' @export
#' @examples
#' \dontrun{
#' # for a logo you'll probably get best results with scalable SVG
#' logo <- div(
#'   img(
#'     attrs=list(
#'       src=file.path("path", "to", "myQuiz.svg"),
#'       class="image",
#'       style="margin-top: 10%;"
#'     )
#'   ),
#'   attrs=list(class="imagediv")
#' )
#'
#' # even better: embed the image into the HTML file
#' img64 <- base64encode(file.path("path", "to", "myQuiz.svg"), linewidth=80, newline="\n")
#' logo <- div(
#'   img(
#'     attrs=list(
#'       src=paste0("data:image/svg+xml;base64,", img64),
#'       class="image",
#'       style="margin-top: 10%;"
#'     )
#'   ),
#'   attrs=list(class="imagediv")
#' )
#'
#' # finally, write the title page
#' titlepage(
#'   logo,
#'   quizfile=file.path("path", "to", "myQuiz.html"),
#'   file=file.path("path", "to", "index.html"),
#'   sound=file.path("path", "to", "myQuiz_main_title.ogg"),
#'   overwrite=TRUE
#' )
#' }

titlepage <- function(..., quizfile, file=NULL, title="iRcotofun", sound=NULL, css=NULL, overwrite=FALSE){
  iRcPath <- installed.packages()["iRcotofun", "LibPath"]
  if(is.null(css)){
    css <- file.path(iRcPath, "iRcotofun", "files", "titlepage.css")
    if(!file.exists(css)){
      stop(simpleError("Can't find 'titlepage.css' CSS file! Is you installation ok?"))
    } else {}
  } else {}
  fullCSS <- paste0(readLines(css), collapse="\n")
  if(!file.exists(quizfile)){
    stop(simpleError(paste0("Can't find quizfile file:\n  ", quizfile)))
  } else {}
  # make a relative path of 'quizfile' if it's in the same directory as 'file'
  if(identical(dirname(quizfile), dirname(file))){
    quizfile <- basename(quizfile)
  } else {}
  head <- XMLNode("head",
    XMLNode("title", title),
    XMLNode("style",
      fullCSS,
      attrs=list(type="text/css")),
    XMLNode("script",
      attrs=list(type="text/javascript"),
      paste0("function newpage(){\n",
        "  window.location.href = \"", quizfile, "\";\n",
        "}"
      )
    )
  )

  fullHTML <- list(
    a(
      attrs=list(href=quizfile, class="centered"),
      .children=list(...)
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
          autoplay="",
          onended="newpage()",
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
