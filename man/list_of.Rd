% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/list_of.R
\name{list_of}
\alias{list_of}
\alias{as_list_of}
\alias{new_list_of}
\alias{is_list_of}
\title{Construct "list_of" objects}
\usage{
list_of(..., .type = NULL)

as_list_of(x, ...)

new_list_of(x, .type)

is_list_of(x)
}
\arguments{
\item{...}{Vectors to coerce. All vectors must be 1d (i.e. no data
frames, matrices or arrays).}

\item{.type}{Usually, the type of the output is coerced to a type common to
inputs. Alternatively, you can supply \code{.type} to force the output to
have known type, or to die trying. See \code{\link[=vec_cast]{vec_cast()}} for more details.
\code{.type = character()} and \code{.type = list()} will succeed for all vectors.}

\item{x}{For \code{as_list_of()}, a vector to be coerced to list_of.}
}
\description{
A \code{list_of} object is a list where each element has the same type.
Modifying the list with \code{$}, \code{[}, and \code{[[} preserves the constraint
by coercing all input items.
}
\examples{
x <- list_of(1:3, 5:6, 10:15)
tibble::tibble(x = x)

vec_c(list_of(1, 2), list_of(FALSE, TRUE))
}
