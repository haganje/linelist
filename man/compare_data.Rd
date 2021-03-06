% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compare_data.R, R/print.data_comparison.R
\name{compare_data}
\alias{compare_data}
\alias{compare_data.default}
\alias{compare_data.data_structure}
\alias{compare_data.data.frame}
\alias{print.data_comparison}
\title{Compare structures of two datasets}
\usage{
compare_data(ref, x, ...)

\method{compare_data}{default}(ref, x, ...)

\method{compare_data}{data_structure}(ref, x, use_dim = TRUE,
  use_names = TRUE, use_classes = TRUE, use_values = TRUE, ...)

\method{compare_data}{data.frame}(ref, x, ...)

\method{print}{data_comparison}(x, ...)
}
\arguments{
\item{ref}{the reference \code{data.frame}}

\item{x}{a \code{data.frame} to be compared against a reference}

\item{...}{further arguments passed to other methods}

\item{use_dim}{a \code{logical} indicating if dataset dimensions should be
compared}

\item{use_names}{a \code{logical} indicating if names of the variables should be
compared}

\item{use_classes}{a \code{logical} indicating if classes of the variables should be
compared}

\item{use_values}{a \code{logical} indicating if values of matching
categorical variables should be compared}
}
\value{
an object of class \code{data_comparison}. This is a named list for
each test
}
\description{
This function extracts the structures of two \code{data.frames} and compares them,
issuing a series of diagnostics.
}
\details{
The comparison relies on checking differences in:
\itemize{
\item names of columns
\item classes of the columns (only the first class is used)
\item values of the categorical variables
}
}
\examples{

## no differences
compare_data(iris, iris)

## different dimensions
compare_data(iris, iris[-1, -2])
compare_data(iris[-1, -2], iris) # inverse

## one variable in common but different class and content
compare_data(iris,
             data.frame(Species = letters,
                        stringsAsFactors = FALSE))
}
\author{
Thibaut Jombart
}
