#' @export
to_df = function() {
    # Change to data.table::fread() -> reads in tables much faster
    df = data.table::fread('tmp.csv', sep='\t')
    head(df)
    return(df)
}

#' @export
rm_tmp = function() {
    exec = paste0('rm tmp.csv')
    #print(exec)
    system(exec)
}

# Class definition
#' @export
DB = setClass("DB", 
              contains = "character", 
              slots=c(user='character', 
                      database='character',
                      password='character')
             )

# Generic from scratch
#' @export
setGeneric("sql_query", function(object, query) {
  standardGeneric("sql_query")
})

#' Executes an SQL query on the command line
#'
#' This function executes an defined SQL query on the command line. 
#' The 
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export
setMethod("sql_query",
  c(object = "DB", query = "character"),
  function(object, query) {
    complete_query = paste0('mysql -u ', object@user, 
                            ' -p ', object@password,
                            ' -D ', object@database, 
                            ' -e ', "'", query, "'", 
                            ' > tmp.csv')
    system(complete_query) # Query execution
    df = to_df() # Query into dataframe
    rm_tmp() # Remove temporary file
    return(df)
  }
)

# Maintain this function for already written scripts 
#' @export
mysql_exec = function(user, query, DB) {
    exec = paste0('mysql -u ', user, ' -D ', DB, ' -e ', "'", query, "'", ' > tmp.csv')
    #print(exec)
    system(exec)
    df = to_df()
    rm_tmp()
    return(df)
}

