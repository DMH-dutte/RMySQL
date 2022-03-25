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

#' Class object containing username, database and password for an MySQL query.
#'
#' @param user Username for MySQL accession
#' @param database Database name which should be called in MySQL
#' @param password Password to access the database
#' @keywords SQL MySQL Command Line
#' @examples
#' DB(user='character', database='character', password='character')
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


#' Executes an MySQL query on the command line
#'
#' This function executes an defined SQL query and executes it on the command line. 
#' The query is returned as a dataframe. 
#' @param object A class object containing SQL user, database & password
#' @param query SQL query in character format
#' @keywords SQL MySQL Command Line
#' @return A dataframe of the SQL query
#' @examples
#' sql_query(object=DB(example_object), query = 'character')
#' @export
setMethod("sql_query",
  signature=c(object = "DB", query = "character"),
  definition = function(object, query) {
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

