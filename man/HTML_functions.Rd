% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HTML_functions.R
\name{br}
\alias{a}
\alias{br}
\alias{div}
\alias{em}
\alias{img}
\alias{p}
\alias{span}
\alias{strong}
\alias{table_}
\alias{tbody}
\alias{td}
\alias{th}
\alias{tr}
\title{HTML helper functions}
\usage{
br()

p(..., attrs = NULL)

span(..., attrs = NULL)

div(..., attrs = NULL)

th(..., attrs = NULL)

tr(..., attrs = NULL)

td(..., attrs = NULL)

table_(..., attrs = NULL)

a(..., attrs = NULL)

tbody(..., attrs = NULL)

strong(..., attrs = NULL)

em(..., attrs = NULL)

img(attrs = NULL, embed = TRUE)
}
\arguments{
\item{...}{Child nodes of this node.}

\item{attrs}{A named list of attributes.}

\item{embed}{Logical,
      whether the specified \code{src} file should be ecoded using \code{\link[base64enc:base64encode]{base64encode}}
to ensure they are embedded into the HTML file. This keeps your presentation from breaking if you move it somewhere else.
It will work with ordinary file paths as well, as long as all files remain in place.}
}
\value{
An object of class \code{XiMpLe.node}.
}
\description{
These functions can become handy to generate proper HTML code.
}
\details{
If you want more control over the output of questions and answers,
      you can include HTML code,
given it is in the form of \code{\link[XiMpLe:XiMpLe.node-class]{XiMpLe.node}} objects.

You can of course use \code{\link[XiMpLe:XMLNode]{XMLNode}},
      but it's abit quicker and more
intuitive to rely on these helpers.
}
\note{
: Please note that \code{table_} ends with an underscore, to not confuse it with the
\code{table} function.
}

