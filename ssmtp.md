### Install
> yum install ssmtp

### Configuration
vi /etc/ssmtp/ssmtp.conf
```
root=ssmtp@vpnotes.ru
RewriteDomain=vpnotes.com
Hostname=localhost
AuthUser=ssmtp@vpnotes.ru
AuthPass=*******
AuthMethod=LOGIN
FromLineOverride=YES
```
vi /etc/ssmtp/revaliases
> root:my_login@gmail.com:smtp.gmail.com:587

### Test
echo «test_message» | ssmtp -s «email subject» address_to_send_email@example.com

### Log 
/var/log/maillog
