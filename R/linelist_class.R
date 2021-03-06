# It should also have accessor functions for standard columns:
#   
#  - date of onset
#  - date of report
#  - date of x where x in {death, hospitalization, ...}
#  - sex
#  - age
#  - age group
#  - a function that determines which concepts are available
#  - arbitrary query function based on HXL?

# Convert a data frame to a linelist via as_linelist

#' Create a linelist object
#'
#' @param x a `data.frame` or a `linelist` object
#' @param ... options passed to [set_epivars()]
#' @seealso [get_epivars()], [get_dictionary()], [list_epivars()], [clean_data()]
#' @export
#' @examples
#' md <- messy_data(10)
#' cd <- clean_data(md)
#' ll <- as_linelist(cd, 
#'                   id = "id", 
#'                   date_onset = "date_of_onset", 
#'                   gender = "gender",
#'                   geo_lon = "lon",
#'                   geo_lat = "lat"
#'                  )
#' ll
#' class(ll)
as_linelist <- function(x, ...) {
  UseMethod("as_linelist")
}

#' @rdname as_linelist
#' @export
#' @aliases as_linelist.default
as_linelist.default <- function(x, ...) {
  stop(sprintf("Not implemented for class %s",
               paste(class(x), collapse = ", ")))
}

#' @rdname as_linelist
#' @export
#' @aliases as_linelist.default
as_linelist.data.frame <- function(x, ...) {
  class(x) <- c("linelist", oldClass(x))
  set_epivars(x, ...)
}


#' @rdname as_linelist
#' @export
#' @param i indicator for rows
#' @param j indicator for columns
#' @param drop indicator for whether the data frame should be dropped if reduced
#'   to one column (defaults to FALSE)
"[.linelist" <- function(x, i, j, drop = FALSE) {
  
  new_epivars <- attr(x, "epivars") -> epivars
  the_mask    <- attr(x, "masked-linelist")
  x <- NextMethod()
  enames <- names(epivars)
  for (i in seq_along(epivars)) {
    # Trimming the epivars
    if (!all(epivars[[i]] %in% names(x))) {
      new_epivars[[enames[i]]] <- NULL
    }
  }
  attr(x, "epivars") <- order_epivars(x, new_epivars)
  attr(x, "masked-linelist") <- the_mask
  x

}
