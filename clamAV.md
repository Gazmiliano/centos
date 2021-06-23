### Install
```
yum -y install epel-release
yum clean all
yum -y install clamav-server clamav-data clamav-update clamav-filesystem
yum -y install clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
```
### Configure SELinux
```
setsebool -P antivirus_can_scan_system 1
setsebool -P clamd_use_jit 1
```

### Test configure SElinux
> getsebool -a | grep antivirus

### Configuration
```
sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf
sed -i -e "s/^Example/#Example/" /etc/freshclam.conf
```

vi /etc/clamd.d/scan.conf
>LocalSocket /var/run/clamd.scan/clamd.sock

### Update
>freshclam

### Autostart
```
systemctl start clamd@scan
systemctl enable clamd@scan
```

### Logging
vi /etc/clamd.d/scan.conf
```
LogFile /var/log/clamd.scan
LogFileUnlock yes
LogFileMaxSize 2M
LogTime yes
LogRotate yes
```

vi /etc/freshclam.conf
```
UpdateLogFile /var/log/freshclam.log
LogFileMaxSize 2M
LogTime yes
LogSyslog yes
LogRotate yes
```

vi /etc/webmin/clamav/config
```
clamav_freshclam_log=/var/log/freshclam.log
clamav_freshclam_init_script=/etc/cron.daily/php
clamav_quarantine=/var/spool/amavis/virusmails
clamav_working_path=/tmp
clamav_freshclam_conf=/etc/freshclam.conf
clamav_quarantine_soft=1
clamav_clamav_log=/var/log/clamd.scan
clamav_clamav_conf=/etc/clamd.d/scan.conf
clamav_refresh_use_cron=1
clamav_db2=/var/lib/clamav/daily.cvd
clamav_init_script=/usr/sbin/clamd
clamav_db1=/var/lib/clamav/main.cld
clamav_init_restore_path=/root
```
