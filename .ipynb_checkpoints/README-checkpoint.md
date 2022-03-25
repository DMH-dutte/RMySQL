# easymysql 

# Installation:

```R
# Development version from GitHub:
# install.packages("devtools")
devtools::install_github("https://github.com/DMH-dutte/easymysql")
```

# Usage:

```R
kes2021 = DB(user='gmg', database= 'kes2021', password='')
sql_query(kes2021, 'select * from contigs limit 10;')
```
![Screenshot](img/example_query.png)


```R
sql_query(kes2021, 'show processlist;')
```
![Screenshot](img/example_query2.png)