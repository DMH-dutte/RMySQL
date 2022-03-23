#http://adv-r.had.co.nz/OO-essentials.html
#system2(command="python3", args=c('/home/sunam188/python_classes/easymysql.py', '"select * from proteins;"', 'kes2021', 'tmp.csv'), stdout  = TRUE)
#read.csv('tmp.csv', header=TRUE, sep='\t')
#http://adv-r.had.co.nz/OO-essentials.html
#system2(command="python3", args=c('/home/sunam188/python_classes/easymysql.py', '"select * from proteins;"', 'kes2021', 'tmp.csv'), stdout  = TRUE)
#read.csv('tmp.csv', header=TRUE, sep='\t')


#' @export
to_df = function() {
    # Change to data.table::fread() -> reads in tables much faster
    df = data.table::fread('.tmp.csv', sep='\t')
    head(df)
    return(df)
}

#' @export
rm_tmp = function() {
    exec = paste0('rm .tmp.csv')
    #print(exec)
    system(exec)
}

#Class definition
#' @export
DB = setClass("DB", 
              contains = "character", 
              slots=c(user='character', 
                      database='character',
                      password='character')
             )

#Generic from scratch
#' @export
setGeneric("sql_query", function(object, query) {
  standardGeneric("sql_query")
})

#Method definition
#' @export
setMethod("sql_query",
  c(object = "DB", query = "character"),
  function(object, query) {
    complete_query = paste0('mysql -u ', object@user, 
                            ' -p ', object@password,
                            ' -D ', object@database, 
                            ' -e ', "'", query, "'", 
                            ' > .tmp.csv')  
    system(complete_query) # Query execution
    df = to_df() # Query into dataframe
    rm_tmp() # Remove temporary file
    return(df)
  }
)

# Example of class usage
#kes2021 = DB(user='gmg', database= 'kes2021', password='')
#sql_query(kes2021, 'select * from contigs limit 10;')

# Maintain this function for own purposes
#' @export
mysql_exec = function(user, query, DB) {
    exec = paste0('mysql -u ', user, ' -D ', DB, ' -e ', "'", query, "'", ' > .tmp.csv')
    #print(exec)
    system(exec)
    df = to_df()
    rm_tmp()
    return(df)
}

