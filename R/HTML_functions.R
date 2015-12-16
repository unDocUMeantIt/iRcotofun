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

#' HTML helper functions
#' 
#' These functions can become handy to generate proper HTML code.
#' 
#' If you want more control over the output of questions and answers, you can include HTML code,
#' given it is in the form of \code{\link[XiMpLe:XiMpLe.node-class]{XiMpLe.node}} objects.
#' 
#' You can of course use \code{\link[XiMpLe:XMLNode]{XMLNode}}, but it's abit quicker and more
#' intuitive to rely on these helpers.
#' 
#' @note: Please note that \code{table_} ends with an underscore, to not confuse it with the
#' \code{table} function.
#' 
#' @param ... Child nodes of this node.
#' @param attrs A named list of attributes. 
#' @return An object of class \code{XiMpLe.node}.
#' @rdname HTML_functions
#' @import XiMpLe
#' @export
br <- function(){
  return(XMLNode("br"))
}

#' @rdname HTML_functions
#' @export
p <- function(..., attrs=NULL){
  return(XMLNode("p", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
span <- function(..., attrs=NULL){
  return(XMLNode("span", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
div <- function(..., attrs=NULL){
  return(XMLNode("div", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
th <- function(..., attrs=NULL){
  return(XMLNode("th", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
tr <- function(..., attrs=NULL){
  return(XMLNode("tr", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
td <- function(..., attrs=NULL){
  return(XMLNode("td", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
table_ <- function(..., attrs=NULL){
  return(XMLNode("table", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
a <- function(..., attrs=NULL){
  return(XMLNode("a", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
tbody <- function(..., attrs=NULL){
  return(XMLNode("tbody", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
strong <- function(..., attrs=NULL){
  return(XMLNode("strong", attrs=attrs, .children=list(...)))
}

#' @rdname HTML_functions
#' @export
em <- function(..., attrs=NULL){
  return(XMLNode("em", attrs=attrs, .children=list(...)))
}

#' @param embed Logical, whether the specified \code{src} file should be ecoded using \code{\link[base64enc:base64encode]{base64encode}}
#'    to ensure they are embedded into the HTML file. This keeps your presentation from breaking if you move it somewhere else.
#'    It will work with ordinary file paths as well, as long as all files remain in place.
#' @rdname HTML_functions
#' @export
img <- function(attrs=NULL, embed=TRUE){
  image <- attrs[["src"]]
  if(!is.null(image) & file.exists(image)){
    if(isTRUE(embed)){
      img64 <- base64encode(image, linewidth=80, newline="\n")
      # try to set the image type
      if(grepl("svg$", image, ignore.case=TRUE)) {
        imgType <- "svg+xml"
      } else if(grepl("png$", image, ignore.case=TRUE)){
        imgType <- "png"
      } else if(grepl("jpg$|jpeg$", image, ignore.case=TRUE)) {
        imgType <- "jpeg"
      } else if(grepl("gif$", image, ignore.case=TRUE)) {
        imgType <- "gif"
      } else {
        warning(
          paste0("Cannot detect image type, please covert into *.svg, *.png, *.jpg or *.gif if there are problems:\n  ", image)
        )
        imgType <- "bmp"
      }
      attrs[["src"]] <- paste0("data:image/", imgType, ";base64,", img64)
    } else {}
  } else {
    stop(simpleError(paste0(
      "The following file cannot be found:\n  ", image
    )))
  }

  return(XMLNode("img", attrs=attrs))
}

# #' @rdname HTML_functions
# #' @export
#  <- function(..., attrs=NULL){
#   return(XMLNode("", attrs=attrs, .children=list(...)))
# }

