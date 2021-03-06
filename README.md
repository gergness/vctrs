
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vctrs

[![Travis build
status](https://travis-ci.org/r-lib/vctrs.svg?branch=master)](https://travis-ci.org/r-lib/vctrs)
[![Coverage
status](https://codecov.io/gh/hadley/vctrs/branch/master/graph/badge.svg)](https://codecov.io/github/hadley/vctrs?branch=master)

The primary short-term goal of vctrs is to develop a theory of “types”
that help us reason about the “correct” type and shape to return from
vectorised functions that have to combine inputs with different types
(e.g. `c()` and `dplyr::bind_rows()`). For the user, the goal is to be
invisible: a principled approach to type coercion will provide greater
consistency across functions, leading to a more accurate mental model
and fewer suprises.

In the medium-term, we will provide developer documentation for creating
new types of S3 vector. This will describe what you need to do make your
new class by into the vctrs coercion philosophy, well as what base
generics you should be supply methods for.

In the long-run, vctrs will also expand to provide functions that
working with logical and numeric vectors, and vectors in general. It
will become a natural complement to stringr (strings), lubridate
(date/times), and forcats (factors), and bring together various helpers
that are currently scattered across packages like ggplot2 (e.g.
`cut_number()`), dplyr (e.g. `coalese()`), and tidyr (e.g. `fill()`).
vctrs is a low-dependency package suitable that will be used from other
packages like purrr and dplyr.

## Installation

You can install the development version of vctrs from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("r-lib/vctrs")
```

## Example

### Base vectors

``` r
library(vctrs)

# vec_c() basically works like c(), but with stricter rules for what 
# gets coerced
vec_c(TRUE, 1)
#> [1] 1 1
vec_c(1L, 1.5)
#> [1] 1.0 1.5
vec_c(1.5, "x")
#> Error: No common type for double and character

# You can override the rules by supplying the desired type of the output
vec_c(1, "x", .type = character())
#> [1] "1" "x"
vec_c(1, "x", .type = list())
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] "x"

# Coercions will warn when lossy (i.e. you can't round trip)
vec_c(1, 1.5, 2, .type = integer())
#> Warning: Lossy conversion from double to integer
#> At positions: 1
#> [1] 1 1 2
```

### What is a type?

``` r
# Describe the type of a vector with vec_type()
vec_type(letters)
#> type: character
vec_type(1:50)
#> type: integer
vec_type(list(1, 2, 3))
#> type: list
```

Internally, we represent the type of a vector with a 0-length subset of
the vector; that allows us to use value and types interchangeably in
many cases, and we can rely base constructors for empty vectors.

### Data frames

The type of a data frame is the type of each column:

``` r
df1 <- data.frame(x = TRUE, y = 1L)
vec_type(df1)
#> type: data.frame<
#>  x: logical
#>  y: integer
#> >

df2 <- data.frame(x = 1, z = 1)
vec_type(df2)
#> type: data.frame<
#>  x: double
#>  z: double
#> >
```

The common type of two data frames is the common type of each column
that occurs in both data frame frames, and the union of the columns that
are unique:

``` r
max(vec_type(df1), vec_type(df2))
#> type: data.frame<
#>  x: double
#>  y: integer
#>  z: double
#> >
```

### List of

vctr provides a new vector type that represents a list where each
element has the same type (an interesting contrast to a data frame which
is a list where each element has the same *length*).

``` r
x1 <- list_of(1:3, 3:5, 6:8)
vec_type(x1)
#> type: list_of<integer>

# This type is enforced if you attempt to modify the vector
x1[[4]] <- c(FALSE, TRUE, FALSE)
x1[[4]]
#> [1] 0 1 0

x1[[5]] <- factor("x")
#> Error: Can't cast factor to integer
```

## Tidyverse functions

There are a number of tidyverse functions that currently need to do type
coercion. In the long run, their varied and idiosyncratic approaches
will be replaced by the systematic foundation provided by vctrs.

``` r
# Data frame functions
dplyr::inner_join() # and friends
dplyr::bind_rows()
dplyr::summarise()
dplyr::mutate()

tidyr::gather()
tidyr::unnest()

# Vector functions
purrr::flatten()
purrr::map_c()
purrr::transpose()

dplyr::combine()
dplyr::if_else()
dplyr::recode()
dplyr::case_when()
dplyr::coalesce()
dplyr::na_if()
```
