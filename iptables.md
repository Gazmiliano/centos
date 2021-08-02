### Disable firewalld
```
systemctl stop firewalld
systemctl disable firewalld
systemctl mask --now firewalld
```

### Install and Enable Iptables
```
yum install iptables-services
systemctl start iptables
systemctl start ip6tables
systemctl enable iptables
systemctl enable ip6tables
```

### Check the current iptables rules
```
iptables -nvL
ip6tables -nvL
```

### Accept any related or established connections
```
iptables -I INPUT  1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I OUTPUT 1 -m state --state RELATED,ESTABLISHED -j ACCEPT
```
### Allow all traffic on the loopback interface
```
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
```
### Allow ping
```
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
iptables -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
```
### Allow SSH
> iptables -A INPUT -i eth0 -p tcp -m tcp --dport 1111 -m state --state NEW  -j ACCEPT

### Open ports
```
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

### Allow outbound DHCP request
> iptables -A OUTPUT -p udp --dport 67:68 --sport 67:68 -j ACCEPT

### Allow outbound email
```
iptables -A OUTPUT -p tcp -m tcp --dport 25 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 110 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 143 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 465 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 587 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 993 -m state --state NEW  -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 995 -m state --state NEW  -j ACCEPT
```
### Allow apple push - tls://gateway.sandbox.push.apple.com:2195/2196
```
iptables -A OUTPUT -p tcp -m tcp --dport 2195 -m state --state NEW  -j ACCEPT 
iptables -A OUTPUT -p tcp -m tcp --dport 2196 -m state --state NEW  -j ACCEPT
```

### Outbound DNS lookups
> iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT

### Outbound PING requests
> iptables -A OUTPUT -p icmp -j ACCEPT

### Outbound Network Time Protocol (NTP) requests
> iptables -A OUTPUT -p udp --dport 123 --sport 123 -j ACCEPT

### Outbound HTTP
```
iptables -A OUTPUT -p tcp -m tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 443 -m state --state NEW -j ACCEPT
```
### Finally drop others
```
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
```

### Log
```
iptables -A INPUT -j LOG --log-prefix "BLOCKED_INPUT: " --log-level 4
iptables -A FORWARD -j LOG --log-prefix "BLOCKED_FORWARD: " --log-level 4
iptables -A OUTPUT -j LOG --log-prefix "BLOCKED_OUTPUT: " --log-level 4
```

### Save and Restore configuration
```
iptables-save > /etc/sysconfig/iptables
iptables-restore < /etc/sysconfig/iptables
```

### Z
iptables -nvL
iptables -I INPUT -p tcp --dport 3899 -j ACCEPT
