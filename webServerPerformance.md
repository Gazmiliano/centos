### /etc/hosts
On forward request himself to skip DNS request
```
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
<ip-address>  <Hostname>
```
### ApacheBench
*Install*
> yum install httpd-tools

Let’s see how it performs for 5000 requests with a concurrency of 500.
> ab -n 5000 -c 500 https://example.com

### Siege
*Install*
> yum install siege

Let’s run the test with 500 concurrent requests for 5 seconds.
> siege -q -t 5S -c 500 https://example.com
 
### wrk
*Install*
```
yum -y groupinstall 'Development Tools'
yum -y install openssl-devel git
git clone http://github.com/wg/wrk.git
cd wrk
make
cp wrk /usr/local/bin/
```

*Run*
> wrk -t12 -c12 -d30s https://example.com

### Ali (https)
*Install*
> yum install ali

```
Usage:
  ali [flags] <target URL>

Flags:
  -b, --body string                A request body to be sent.
  -B, --body-file string           The path to file whose content will be set as the http request body.
      --cacert string              PEM ca certificate file
      --cert string                PEM encoded tls certificate file to use
  -c, --connections int            Amount of maximum open idle connections per target host (default 10000)
      --debug                      Run in debug mode.
  -d, --duration duration          The amount of time to issue requests to the targets. Give 0s for an infinite attack. (default 10s)
  -H, --header stringArray         A request header to be sent. Can be used multiple times to send multiple headers.
      --insecure                   Skip TLS verification
      --key string                 PEM encoded tls private key file to use
      --local-addr string          Local IP address. (default "0.0.0.0")
  -M, --max-body int               Max bytes to capture from response bodies. Give -1 for no limit. (default -1)
  -W, --max-workers uint           Amount of maximum workers to spawn. (default 18446744073709551615)
  -m, --method string              An HTTP request method for each request. (default "GET")
      --no-http2                   Don't issue HTTP/2 requests to servers which support it.
  -K, --no-keepalive               Don't use HTTP persistent connection.
      --query-range duration       The results within the given time range will be drawn on the charts (default 30s)
  -r, --rate int                   The request rate per second to issue against the targets. Give 0 then it will send requests as fast as possible. (default 50)
      --redraw-interval duration   Specify how often it redraws the screen (default 250ms)
      --resolvers string           Custom DNS resolver addresses; comma-separated list.
  -t, --timeout duration           The timeout for each request. 0s means to disable timeouts. (default 30s)
  -v, --version                    Print the current version.
  -w, --workers uint               Amount of initial workers to spawn. (default 10)

Examples:
  ali --duration=10m --rate=100 http://host.xz
```  

Let’s run the test with 500 concurrent requests for 10 seconds.
> ali --rate=500 --duration=10s https://example.com

### Sysbench (MySql)
*Install*
```
yum install sysbench -y
mysql -u root -p
create database sbtest;
```
*Prepare*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100  --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua prepare
 
*Cleanup*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100 --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua cleanup

*Run*

> sysbench --db-driver=mysql --mysql-user=root --mysql-password=password --mysql-db=sbtest --range_size=100 --table_size=10000 --tables=2 --threads=1 --events=0 --time=60 --rand-type=uniform /usr/share/sysbench/oltp_read_only.lua run

### Gobench
### Apache JMeter
### HTTPLoad (https)
### Curl-loader (https)
### httperf
### Tsung
