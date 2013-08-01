## NGINX and PHP-FPM


Ordnerstruktur: `/opt/www/$user`


### One-time config:

* add the next line at the end of `/etc/php5/fpm/php-fpm.conf`
```
include=/opt/www/*/php-fpm-pool.conf
```


* add `/etc/nginx/nginx.conf` in the http block of `/etc/nginx/nginx.conf`
```
http {
    [...]
    include=/opt/www/*/php-fpm-pool.conf
    [...]
}
```
* copy the `Template` folder to `/opt/www/`



### create a user/site:

* `sudo ./addsftpuser.sh $user`
* restart nginx and php-fpm

##### optional:
* `passwd $user` to enable login
* edit domains in `/opt/www/$user/nginx-server.conf`

```
[...]
server_name $user.de www.$user.de;
[...]
```
