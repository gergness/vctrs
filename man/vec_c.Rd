% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coerce.R
\name{vec_c}
\alias{vec_c}
\title{Concatenate vectors}
\usage{
vec_c(..., .type = NULL)
}
\arguments{
\item{...}{Vectors to coerce. All vectors must be 1d (i.e. no data
frames, matrices or arrays).}

\item{.type}{Usually, the type of the output is coerced to a type common to
inputs. Alternatively, you can supply \code{.type} to force the output to
have known type, or to die trying. See \code{\link[=vec_cast]{vec_cast()}} for more details.
\code{.type = character()} and \code{.type = list()} will succeed for all vectors.}
}
\value{
A vector with length equal to the sum of the lengths of the contents
of \code{...}.

The vector will have names if the individual components have names
(inner names) or if the arguments are named (outer names). If both
inner and outer names are present, they are combined with a \code{.}.
}
\description{
Concatenate vectors using the vctr coercion rules as explained in
\code{\link[=vec_coerce]{vec_coerce()}}.
}
\examples{
vec_c(FALSE, 1L, 1.5)
vec_c(FALSE, 1L, "x", .type = character())

# Date/times --------------------------
c(Sys.Date(), Sys.time())
c(Sys.time(), Sys.Date())

vec_c(Sys.Date(), Sys.time())
vec_c(Sys.time(), Sys.Date())

# Factors -----------------------------
c(factor("a"), factor("b"))
vec_c(factor("a"), factor("b"))
}
