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


#' Class iRc_category
#'
#' Objects of this class represent one category in a iRcotofun game. They are combined to a game
#' by the function \code{\link[iRcotofun:ircotofun]{ircotofun}}.
#' To create categories, use the function \code{\link[iRcotofun:category]{category}}.
#'
#' @slot name Character string, name of the category. 
#' @slot items A list of objects of class \code{\link[iRcotofun:iRc_item-class]{iRc_item}}.
#' @name iRc_category,-class
#' @aliases iRc_category-class iRc_category,-class
#' @import methods
#' @keywords classes
#' @rdname iRc_category-class
#' @export

setClass("iRc_category",
  representation=representation(
    name="character",
    items="list"
  ),
  prototype(
    name=character(),
    items=list()
  )
)

setValidity("iRc_category", function(object){
  obj_name <- slot(object, "name")
  obj_items <- slot(object, "items")
  
  if(isTRUE(!nchar(obj_name) > 0) | isTRUE(length(obj_name) != 1)){
    stop(simpleError("Invalid object: \"name\" must be a single character string!"))
  } else {}

  for (thisItem in obj_items){
    if(!inherits(thisItem, "iRc_item")){
      stop(simpleError(paste0("Invalid object: All \"items\" must be of class \"iRc_item\", but got \"", class(thisItem), "\"!")))
    } else {}
  }

  return(TRUE)
})
