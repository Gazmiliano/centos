### /etc/hosts
On forward request himself to skip DNS request
```
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
<ip-address>  <Hostname>
```
### ApacheBench
*Install*
> yum install httpd-tools

Let’s see how it performs for 5000 requests with a concurrency of 500.
> ab -n 5000 -c 500 https://example.com

### Siege
*Install*
> yum install siege

Let’s run the test with 500 concurrent requests for 5 seconds.
> siege -q -t 5S -c 500 https://example.com
 
### wrk
*Install*
```
yum -y groupinstall 'Development Tools'
yum -y install openssl-devel git
git clone http://github.com/wg/wrk.git
cd wrk
make
cp wrk /usr/local/bin/
```

*Run*
> wrk -t12 -c12 -d30s https://example.com

### Ali (https)
*Install*
> yum install ali

Let’s run the test with 500 concurrent requests for 10 seconds.
> ali --rate=500 --duration=10s https://example.com

### Sysbench (MySql)
*Install*
```
yum install sysbench -y
mysql -u root -p
create database sbtest;
```
*Prepare*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100  --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua prepare
 
*Cleanup*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100 --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua cleanup

*Run*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100 --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua run

### Gobench
### Apache JMeter
### HTTPLoad (https)
### Curl-loader (https)
### httperf
### Tsung
