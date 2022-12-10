# traffic_violations_db

Here is a database which stores information about penalties of drivers accused of traffic violations. 

1. makefile.sql creates tables
2. filltables.sql puts some data in tables to check if triggers work correctly
3. triggers.sql instructs database how to process insertion and removal (it is allowed to insert and remove more than one line at once)
4. diagram.png and scheme.png illustrates what are the dependencies between tables
5. query.sql and tmp.sql contain irrelevant implementation of some triggers, actual implementation is described in triggers.sql
