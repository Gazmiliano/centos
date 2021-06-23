### Check DNS
On client machine
>ping hostname 

On server
```
hostnamectl
  Transient hostname: hostname
```  

### Configure DNS (Server)
vi /etc/resolv.conf
```
search (domain name)
nameserver 8.8.8.8
```

### Set hostname 
> hostnamectl set-hostname your-new-hostname
 
After reebot hostname must contain short and full name
  
### Sub domains
First add DNS record (Provider)
> sub.test.com. 1800 IN A 123.345.234.4

Nginx configuration
> server_name sub.test.com;

### AntiFreeze /etc/hosts
Add all sub domains 
