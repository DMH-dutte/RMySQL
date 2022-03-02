
#system2(command="python3", args=c('/home/sunam188/python_classes/easymysql.py', '"select * from proteins;"', 'kes2021', 'tmp.csv'), stdout  = TRUE)
#read.csv('tmp.csv', header=TRUE, sep='\t')


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
    print(exec)
    system(exec)
}


#' @export
mysql_exec = function(user, query, DB) {
    exec = paste0('mysql -u ', user, ' -D ', DB, ' -e ', "'", query, "'", ' > tmp.csv')
    print(exec)
    system(exec)
    df = to_df()
    rm_tmp()
    return(df)
}



#mysql_exec("gmg", c('select * from proteins;'), "kes2021")
#df = to_df()
#head(df)
#rm_tmp()