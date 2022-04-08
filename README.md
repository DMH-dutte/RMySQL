# RMySQL

<p align="center">
    <img src="https://github.com/DMH-dutte/RMySQL/blob/main/img/database.png" width="400" />
</p>

# Installation:

```R
# Development version from GitHub:
# install.packages("devtools")
devtools::install_github("https://github.com/DMH-dutte/RMySQL")
```

# Usage:

```R
kes2021 = DB(user='gmg', database= 'kes2021', password='')
sql_query(kes2021, 'select * from contigs limit 10;')
```

<p align="center">
  <img src="img/example_query.png">
</p>


```R
sql_query(kes2021, 'show processlist;')
```

<p align="center">
  <img src="img/example_query2.png">
</p>
