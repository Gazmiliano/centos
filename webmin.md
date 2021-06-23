### Install
Creating repository
>vi /etc/yum.repos.d/webmin.repo

```
[Webmin]
name=Webmin Distribution Neutral
#baseurl=http://download.webmin.com/download/yum
mirrorlist=http://download.webmin.com/download/yum/mirrorlist
enabled=1
```
>yum install webmin

### Manual install
Download
```
wget https://prdownloads.sourceforge.net/webadmin/webmin-1.900-1.noarch.rpm 
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/perl-Net-SSLeay-1.55-6.el7.x86_64.rpm
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/perl-Encode-Detect-1.01-13.el7.x86_64.rpm
```  
Install
```
rpm –ivhperl-Net-SSLeay-1.55-6.el7.x86_64.rpm
rpm –ivhperl-Encode-Detect-1.01-13.el7.x86_64.rpm
rpm –ivhwebmin-1.900-1.noarch.rpm
```

### Run
>servicewebmin start

### Autostart
>chkconfigwebmin on

### Add google authenticator
```
yum-y install perl-CPAN
perl-MCPAN -e "install Test::Moose"
perl-MCPAN -e "install Types::Standard"
perl-MCPAN -e "install Moo"
perl-MCPAN -e "install Authen::OATH"
```
