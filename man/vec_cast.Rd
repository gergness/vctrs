% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cast.R
\name{vec_cast}
\alias{vec_cast}
\title{Export cast a vector to specified type}
\usage{
vec_cast(x, to)
}
\arguments{
\item{x}{Vector to cast.}

\item{to}{Type to cast to.}
}
\value{
A vector the same length as \code{x} with the same type as \code{to},
or an error if the cast is not possible. A warning is generated if
information is lost when casting between compatible types (i.e. when
there is no 1-to-1 mapping for a specific value).
}
\description{
Casting supports a wider range of transformations that are automatically
imputed by coercion (e.g. with \code{\link[=vec_coerce]{vec_coerce()}}).
}
\section{Casting rules}{


Casting is more flexible than coercion, and allows for the possibility of
information loss. This diagram summarises possible coercions. \code{vec_cast()}
from any type connected to another type, provided that the arrows are
followed in only one direction. For example you can cast from logical to
character, and list to time, but you can not cast from logical to datetime.

\figure{cast.png}

The rules for coercing from a list a fairly strict: each component of the
list must be of length 1, and must be coercible to type \code{to}.
}

\examples{
# x is a double, but no information is lost
vec_cast(1, integer())

# Information is lost so a warning is generated
vec_cast(1.5, integer())

# No sensible coercion is possible so an error is generated
\dontrun{
vec_cast(1.5, factor("a"))
}

}
\keyword{internal}
