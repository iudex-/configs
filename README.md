# NGINX and PHP-FPM


Ordnerstruktur: `/opt/www/$user`



add
    include=/opt/www/*/php-fpm-pool.conf
to `/etc/php5/fpm/php-fpm.conf`


add
    http {
        [...]
        include=/opt/www/*/php-fpm-pool.conf
        [...]
    }
to `/etc/nginx/nginx.conf`



create a user/site: 
* `addsftpuser.sh $user`
* restart nginx and php-fpm
* `passwd $user` to enable login [optional]


add Domains in `/opt/www/user/`
    [...]
    server_name $user.de www.$user.de;
    [...]
