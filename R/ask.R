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

#' Ask a quiz question
#' 
#' Creates an object of class \code{\link[iRcotofun:iRc_item-class]{iRc_item}}.
#' 
#' Both parameters must be named character strings (or vectors). Currently these names are supported:
#' \describe{
#'    \item{text: }{The value will be pasted as-is to the HTML document.}
#'    \item{img: }{The value wil be treated as the relative path to an image.}
#'    \item{html: }{The value must be a XiMpLe.node object.}
#' }
#'
#' @param question Named character string to be used as the question. See details for valid names. 
#' @param answer Character string to be used as the answer. See details for valid names.
#' @return An object of class \code{iRc_item}.
#' @rdname ask
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

ask <- function(question, answer){
  return(
    new("iRc_item",
      question=question,
      answer=answer
    )
  )
}
