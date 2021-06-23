### For max connections Nginx:

Each connect require 2 file discriptor: connect and to open file
- open files - max opened files, max = 65535
- max user processes - max run processes, max = 65535  
- hard limit - A hard limit can only be raised by root. So it is useful for security
- soft limit - A non-root process cannot overstep a hard limit
- unix socket accept 128 connections by default. /etc/sysctl.conf
  
### Check OS limits
> ulimit -a
  
> su - mysql -c 'ulimit -aHS' -s '/bin/bash'
  
> su - nginx -c 'ulimit -aHS' -s '/bin/bash'
  
### Current number of open files:  
> cat /proc/sys/fs/file-nr
  
### Set limits
> vi /etc/sysctl.conf
  
> fs.file-max = 65535

/etc/security/limits.conf
```
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
```
  
/etc/security/limits.d/90-nproc.conf
```
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
```
### Apply
> sysctl -p
  
### For service
> systemctl edit nginx.service
```  
[Service]
LimitNOFILE=16000
LimitNOFILESoft=16000
```
  
> systemctl edit unit.service
```  
[Service]
LimitNOFILE=16000
LimitNOFILESoft=16000
```
  
> systemctl daemon-reload
  
> systemctl restart nginx.service

> systemctl restart unit.service

### Check Service limit
> service nginx status

> cat /proc/pid/limits 

### MySql limits
Max connections:
```
mysql> show variables like 'max_connections';
+-----------------+-------+
| Variable_name   | Value |
+-----------------+-------+
| max_connections | 100   |
+-----------------+-------+
1 row in set (0.00 sec)

mysql> SET GLOBAL max_connections = 150;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like 'max_connections';
+-----------------+-------+
| Variable_name   | Value |
+-----------------+-------+
| max_connections | 150   |
+-----------------+-------+
1 row in set (0.00 sec)
```
