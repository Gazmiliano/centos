### Install nginx
> yum install epel-release

> yum install nginx

### Autoload
> systemctl start nginx

### Configuration
> vi /etc/nginx/conf.d/default.conf

```
server { 
    listen       80;
    server_name  localhost;

    location / {    
        root   /usr/share/nginx/html;        
        index  index.html index.htm;        
    }
    
    error_page   500 502 503 504  /50x.html;
    
    location = /50x.html {    
        root   /usr/share/nginx/html;        
    }    
}
```

### Configuration of error page nginx
```
    error_page 403 e400.html;
    error_page 404 e400.html;

    location = /e400.html {
        root  /usr/share/nginx/html;
        allow all;
    }

```

### Apply configuration
> systemctl restart nginx

### Test
> http://server_domain_name_or_IP/

### Change nginx port
In CentOS or RHEL based Linux distribution you need to install policycoreutils package and add the below rules required by SELinux for Nginx to bind on the new port.
> yum install policycoreutils

> semanage port -a -t http_port_t -p tcp 3200
 
> semanage port -m -t http_port_t -p tcp 3200

### Optimization /etc/nginx/nginx.conf
1) Adjust worker_processes
   > worker_processes = CPU number   
   > worker_connections = worker_processes * worker_connections (max clients)
2) Enable Gzip compression
```
  gzip on;
  gzip_proxied any;
  gzip_types text/plain text/xml text/css application/x-javascript;
  gzip_vary on;
  gzip_disable “MSIE [1-6]\.(?!.*SV1)”;
```
3) Enable cache for static files
```
  location ~*  \.(jpg|jpeg|png|gif|ico|css|js)$ {
     expires 365d;
  }
```
4) Disable access_logs
> access_log off;
5) Monitor your Nginx servers with Monitis
