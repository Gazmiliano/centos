### Install
> yum install fail2ban
 
### Configuration
- /etc/fail2ban/fail2ban.conf. Fail2ban configuration
- /etc/fail2ban/jail.conf. Services (sshd,ftp ...) secure configuration 

jail.conf:
- ignoreip. Presistent ip address that will not banned
- bantime. Blocked ip address ban time (sec)
- maxretry. Max retry after ban
- enabled. [Jail] action = True or false. 
- port. Whitch port service started. Default ssh - 22
- filter. Search filter. sshd - /etc/fail2ban/filter.d/sshd.conf
- logpath. Service log path to process

```
[DEFAULT]
ignoreip = <remote ip address>

[ssh]
enabled     = true
findtime    = 86400 <24 hour>
maxretry    = 6
bantime     = 86400 <24 hour>
```

### Apply configuration
> service fail2ban restart
 
### Log
/var/log/fail2ban.log
