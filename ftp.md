### Install vsftpd
> yum install vsftpd ftp -y
vi /etc/vsftpd/vsftpd.conf
```
anonymous_enable=NO
ascii_upload_enable=YES
ascii_download_enable=YES
ftpd_banner=Welcome to UNIXMEN FTP service.
use_localtime=YES
```
### Autostart and start
```
systemctl enable vsftpd
systemctl start vsftpd
```
### Allow (Firewall)
```
firewall-cmd --permanent --add-port=21/tcp
firewall-cmd --permanent --add-service=ftp
firewall-cmd --reload
```
### Allow (SElinux)
>setsebool -P ftp_home_dir on

### Allow (Directory)
```
chown -R ftp:ftp /var/ftp
semanage fcontext -a -t public_content_rw_t /var/ftp
restorecon -Rvv /var/ftp
setsebool -P ftp_home_dir 1
setsebool -P ftpd_full_access 1
ls -lZ /var | grep ftp
drwxr-xr-x. ftp ftp system_u:object_r:public_content_rw_t:s0 ftp
```

### Debug SElinux
```
yum install setroubleshoot setools
sealert -b
```

### SFTP + php
```
yum install php-devel
yum install libssh2-devel
yum install php-pear
pecl install ssh2-0.13
```
==============================================\
Build process completed successfully\
Installing '/usr/lib64/php/modules/ssh2.so'\
install ok: channel://pecl.php.net/ssh2-0.13\
configuration option "php_ini" is not set to php.ini location\
You should add "extension=ssh2.so" to php.ini
