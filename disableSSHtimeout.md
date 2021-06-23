### Error
Connection to example.com closed by remote host.\
Connection to example.com closed. 

- Avoid SSH timeout from the server
- Avoid SSH timeout from the client

### Avoid SSH timeout from the server
1) vi /etc/ssh/sshd_config
2) TCPKeepAlive no \
ClientAliveInterval 30 \
ClientAliveCountMax 240
3) service sshd restart

### Avoid SSH timeout from the client
1) vi /etc/ssh/ssh_config
2) ServerAliveInterval 30
