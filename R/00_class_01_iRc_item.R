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


#' Class iRc_item
#'
#' Objects of this class represent one item in a iRcotofun game. They are combined to a category
#' in objects of class iRc_Category. To freate items, use the function \code{\link[iRcotofun:ask]{ask}}.
#'
#' Both slots must be named character strings (or vectors). Currently these names are supported:
#' \describe{
#'    \item{text: }{The value will be pasted as-is to the HTML document.}
#'    \item{img: }{The value will be treated as the relative path to an image.}
#'    \item{html: }{The value must be a XiMpLe.node object.}
#' }
#'
#' @slot question Named list to be used as the question. See details for valid names. 
#' @slot answer Named list to be used as the answer. See details for valid names.
#' @name iRc_item,-class
#' @aliases iRc_item-class iRc_item,-class
#' @import methods
#' @keywords classes
#' @rdname iRc_item-class
#' @export

setClass("iRc_item",
  representation=representation(
    question="list",
    answer="list"
  ),
  prototype(
    question=list(),
    answer=list()
  )
)

setValidity("iRc_item", function(object){
  obj_question <- slot(object, "question")
  obj_answer <- slot(object, "answer")
  obj_q_names <- names(obj_question)
  obj_a_names <- names(obj_answer)
  
  valid_names <- c("text","img","html")

  # check that they all have names
  if(length(obj_q_names) > 0){
    if(length(obj_q_names) != length(obj_question)){
      stop(simpleError("Invalid object: All \"question\" values must have names!"))
    } else {
      # check for valid names
      invalid_names <- !obj_q_names %in% valid_names
      if(any(invalid_names)){
        stop(simpleError(paste0("Invalid name in \"question\": ", paste(obj_q_names[invalid_names], collapse=", "))))
      } else {}
    }
  } else {}
  if(length(obj_a_names) > 0){
    if(length(obj_a_names) != length(obj_answer)){
      stop(simpleError("Invalid object: All \"answer\" values must have names!"))
    } else {
      # check for valid names
      invalid_names <- !obj_a_names %in% valid_names
      if(any(invalid_names)){
        stop(simpleError(paste0("Invalid name in \"answer\": ", paste(obj_a_names[invalid_names], collapse=", "))))
      } else {}
    }
  } else {}

  allParts <- c(obj_question, obj_answer)
  for (thisPartNum in 1:length(allParts)){
    thisPartValue <- allParts[thisPartNum]
    thisPartName <- names(allParts)[thisPartNum]
    if(is.XiMpLe.node(thisPartValue)){
      if(!identical(thisPartName, "html")){
        stop(simpleError("'html' values must be XiMpLe.node objects!"))
      } else {}
    } else {
      if(is.character(thisPartValue) & isTRUE(!nchar(thisPartValue) > 0)){
        print(str(object))
        stop(simpleError("Invalid object: Both \"question\" and \"answer\" must have a a value!"))
      } else {}
    }
  }

  return(TRUE)
})
