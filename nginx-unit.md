### Install
Create file /etc/yum.repos.d/unit.repo:

```
[unit]
name=unit repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
```

> yum install unit

> yum install unit-devel unit-php 

### Start
> systemctl enable unit

> systemctl start unit

### Configuration
*Copy*
> cp -p /usr/share/doc/unit-php-1.22.0/unit.example-php-config /etc/unit/test.config

*Add*
> curl -X PUT -d @/etc/unit/test.config --unix-socket /var/run/control.unit.sock http://localhost/config/applications/test

*View*
> curl --unix-socket /var/run/control.unit.sock http://localhost/

*Test configuration*
```
    {
        "type": "php",
        "root": "/usr/share/nginx/html/agrogold"
    }
```    

*Add*
> curl -X PUT -d @/etc/unit/test.config --unix-socket /var/run/control.unit.sock http://localhost/config/applications/blogs

*Delete*
> curl -X DELETE --unix-socket /var/run/control.unit.sock 'http://localhost/config/applications/blogs'

### Troubleshouting
*broken pipe (increase timeout)*
```
location / {
    proxy_read_timeout 300s;
    proxy_connect_timeout 75s;
    proxy_pass http://localhost:3000;
}
```

