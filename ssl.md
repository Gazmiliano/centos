### Configuration
https://sectigo.com/resource-library/install-certificates-nginx-webserver

https://ssl-config.mozilla.org/

### SSL test
https://www.ssllabs.com/ssltest

> echo 'EXIT' | openssl s_client -connect  my_server_address:443 -servername mydomain -tls1 -tlsextdebug -status

### Troubleshouting (not resolved)
nginx error:
OCSP_basic_verify() failed (SSL: error:27069076:OCSP routines:OCSP_basic_verify:signer certificate not found)

send() failed (111: Connection refused) while resolving, resolver: 127.0.0.1:53

### Nginx cache
```
http {
    ssl_session_cache   shared:SSL:100m;
    ssl_session_timeout 1h;
}
```
1 megabyte cache = 4000 sessions

shared:SSL:100m = 400 000 sessions

### Nginx riderect http -> https
> add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
