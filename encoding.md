1) for Apache .htaccess: AddDefaultCharset utf-8
2) for Nginx (configuration): charset utf8;
3) for Html:
```html
<head>    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
```
for html 5:
```html
<meta charset="UTF-8">
```
4) for tables set encoding: utf8_general_ci
5) for php-sql:
```php
new PDO('mysql:host=localhost;dbname=db;charset=utf8;','user','pass')
```
```php
mysql_query('SET NAMES "utf8"');
```
6) IDE save format - utf8
