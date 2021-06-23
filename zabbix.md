### Install
Zabbix Server depends on the following software applications:
- Apache web server
- PHP with required extensions
- MySQL/ MariaDB database server

It is recommended to have SELinux in permissive mode unless you know how to fix its issues
```
setenforce 0 sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
cat /etc/selinux/config | grep SELINUX=
```
PHP extensions:
>yum -y install php php-pear php-cgi php-common php-mbstring php-snmp php-gd php-xml php-mysql php-gettext php-bcmath

Add Zabbix 4.0 repository
>sudo yum install -y https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm

>yum install -y zabbix-server-mysql zabbix-web-mysql zabbix-agent zabbix-get

Import initial schema and data for the server with MySQL:
>zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix

Edit your Zabbix configuration file  /etc/zabbix/zabbix_server.conf and set database connection settings.
```
DBName=zabbix
DBUser=zabbix
DBPassword=StrongPassword
```
```
sudo systemctl restart httpd zabbix-server
sudo systemctl enable zabbix-server
```
Apache configuration file for Zabbix frontend is located \
/etc/httpd/conf.d/zabbix.conf. 
```
php_value date.timezone Asia/Almaty
php_value max_execution_time 300
php_value memory_limit 128M
php_value post_max_sizoe 16M
php_value upload_max_filesize 2M
php_value max_input_time 300
php_value max_input_vars 10000
```
