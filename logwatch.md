### Install logwatch
> yum -y install logwatch
### Copy default config
> cp /usr/share/logwatch/default.conf/logwatch.conf /etc/logwatch/conf/logwatch.conf
### Configuration
- LogDir — All log-files are assumed to be given relative to this directory;
- MailTo —  Default person to mail reports to;
- Range — The current choices are All, Today, Yesterday;
- Detail — The default detail level for the report. This can either be Low, Med, High or a number;
- Service — The default service(s) to report on.  This should be left as All for most people;
### Test
> logwatch --detail Low --mailto root --service exim --range today
### More info
> /usr/share/doc/logwatch-7.3.6/HOWTO-Customize-LogWatch
