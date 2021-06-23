Mysqltuner — it is perl script, for analyze mysql. As result gives optimal configuration mysql

### Install
```
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl --no-check-certificate
yum -y install mysqltuner
```
### Run
```
perl mysqltuner.pl --user root --pass rootpassword
mysqltuner
mysqltuner --user root --pass rootpassword
```

### Binary log
mysqlbinlog — Utility for Processing Binary Log Files

### Configuration (my.cnf)
> binlog-format=ROW
- statement. Writes sql request. Old format, tested very well, small log, possible to view logs. Have problems with functions and triggers
- row. Writes changed data requests. Big size, logging all requests
- mixed. Trying like statement if not then like row. Maybe have bugs

### Master server (my.cnf)
```
server-id = 1
log-bin = /home/mysql/mysql-bin
replicate-do-db = databaseName
```

```
mysql> CREATE USER 'repl'@'hostname' IDENTIFIED BY 'password';
mysql> GRANT REPLICATION SLAVE ON *.* TO 'databaseName'@'hostname';
```

>service mysqld restart

### Replica server (my.cnf)
```
server-id = 2
relay-log = /var/lib/mysql/mysql-relay-bin
relay-log-index = /var/lib/mysql/mysql-relay-bin.index
replicate-do-db = databaseName
```

### Transfer data
Master server
```
mysql@master> FLUSH TABLES WITH READ LOCK;
mysql@master> SET GLOBAL read_only = ON;
```
Replica server
```
CHANGE MASTER TO MASTER_HOST = "hostname", MASTER_USER = "repl", MASTER_PASSWORD = "password ", MASTER_LOG_FILE = "mysql-bin.000001", MASTER_LOG_POS = 1;
start slave;
```
