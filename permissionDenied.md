If you are using a version of Linux that has SELinux enabled then you should also execute this in a shell:
```
chcon -R --type httpd_sys_rw_content_t /path/to/your/directory
chcon -R --type httpd_sys_rw_content_t /tmp
chmod 777 /path
```
