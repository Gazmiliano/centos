### Install
```
yum install -y make gcc cc gcc-c++ wget
yum install -y openssl-devel libevent libevent-devel mysql-devel mysql-server

cd /usr/src/libevent
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xvfz libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable && ./configure
make && make install && cd

cd /usr/src/turnserver
wget http://turnserver.open-sys.org/downloads/v3.2.3.8/turnserver-3.2.3.8.tar.gz
tar -xvzf turnserver-3.2.3.8.tar.gz
cd turnserver-3.2.3.8 && ./configure
make && make install
```

### Configure
cp /usr/local/share/examples/turnserver/etc/turnserver.conf /etc/turnserver/turnserver.conf\
vi /etc/turnserver/turnserver.conf
```
listening-port=3478
mysql-userdb="host=localhost dbname=turn user=turn password=turn port=3306 connect_timeout=30"
```
Iptables -> open port -> 3478

### Mysql
mysql -p mysql
```
create user 'turn'@'localhost' identified by 'turn';
create database turn;
grant all on turn.* to 'turn'@'localhost';
flush privileges;
```
mysql -p -u turn turn < turndb/schema.sql
bin/turnadmin -s logen -M "host=localhost dbname=turn user=turn password=turn"

Long-term credentials mechanism:
```
bin/turnadmin -a -M "host=localhost dbname=turn user=turn password=turn" -u gorst -r north.gov -p hero
bin/turnadmin -a -M "host=localhost dbname=turn user=turn password=turn" -u ninefingers -r north.gov -p youhavetoberealistic
```  
Long-term credentials mechanism with SHA256 extention:
```
bin/turnadmin -a -M "host=localhost dbname=turn user=turn password=turn" -u bethod -r north.gov -p king-of-north --sha256
```  
Short-term credentials mechanism:
```
turnadmin -A -M "host=localhost dbname=turn user=turn password=turn" -u gorst -r north.gov -p hero
turnadmin -A -M "host=localhost dbname=turn user=turn password=turn" -u ninefingers -r north.gov -p youhavetoberealistic
```
  
### Add admin
```
turnadmin -a -u prouser -r red5pro.com -p 3TptDG7cAfz5TaXsda
turnadmin -a -u prouser -r red5pro.com -p 3TptDG7cAfz5TaXsda
```
