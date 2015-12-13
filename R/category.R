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

#' Create a quiz category
#' 
#' Creates an object of class \code{\link[iRcotofun:iRc_category-class]{iRc_category}}.
#' 
#' @param name Character string, name of the category. 
#' @param ... Objects of class \code{\link[iRcotofun:iRc_item-class]{iRc_item}}.
#' @return An object of class \code{iRc_category}.
#' @rdname category
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
#' # now make a category
#' farscape <- category(name="Farscape", q1, q2, q3, q4)

category <- function(name, ...){
  return(
    new("iRc_category",
      name=name,
      items=list(...)
    )
  )
}
