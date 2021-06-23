### MySQL install
```
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
```
Selecting a Release Series  
> vi /etc/yum.repos.d/mysql-community.repo  

For example, enabling 5.6 version
```
[mysql56-community]
name=MySQL 5.6 Community Server  
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/  
enabled=1  
gpgcheck=1  
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```
`enabled=0` or `enabled=1`  

```
yum install mysqld
mysql_install_db
```
### Autoload
```
systemctl start mysqld
systemctl enable mysqld
```
### Set root password
> mysql_secure_installation
