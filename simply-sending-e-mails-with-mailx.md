###  Installing mailx

```shell
yum -y update
```

```shell
yum install -y mailx
```
We can now start sending e-mails using

**create a symbolic link**
```shell
ln -s /bin/mailx /bin/email
```
###Set an External SMTP Server to Relay E-Mails
```shell
vi /etc/mail.rc
```
edit
```
set smtp=smtps://smtp.gmail.com:465
set smtp-auth=login
set smtp-auth-user=USERNAME@YOURDOMAIN.COM
set smtp-auth-password=YOURPASSWORD
set ssl-verify=ignore
set nss-config-dir=/etc/pki/nssdb/
```
example usage :

```shell
echo "Your message" | mail -v -s "Message Subject" email@address
```