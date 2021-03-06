#' extractVariableGroups
#' 
#' Groups variable names by groups based on the |+| separators given in the variable names
#' 
#' @param x a vector of variable names
#' @return a named list of variable groups with group name as name and vector of entities as content
#' @author David Klein, Jan Philipp Dietrich
#' @seealso \code{\link{plotstyle.add}}
#' @examples
#' x <- c("a|+|1|+|aa","a|+|2|abc","a|+|1|+|bb","a|+|1|+|cc","a|+|3|+|aa","a|+|3|+|bb")
#' mip:::extractVariableGroups(x)

extractVariableGroups <- function(x) {
  tmp <- function(x,sep="|+|",ext="") {
    y <- strsplit(x,sep, fixed=TRUE)
    out <- list()
    for(j in 1:length(y)) {
      for(i in 1:(length(y[[j]])-1)) {
        name <- paste0(paste(y[[j]][1:i],collapse=sep),ext)
        out[[name]] <- c(out[[name]],x[j])
      }
    }
    return(out)
  }
  out <- list()
  for(i in 1:10) {
    sep <- paste0("|",paste(rep("+",i),collapse=""),"|")
    matches <- grep(sep,x,fixed=TRUE, value = TRUE)
    if(length(matches)==0) break()
    ext <- ifelse(i>1,paste0(" ",i),"")
    out <- c(out,tmp(matches,sep=sep,ext=ext))
  }
  return(out)
}



