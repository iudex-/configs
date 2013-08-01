#!/bin/bash

exec 2>/dev/null # Turn off error messages (important for the id command because it would tell if a user did not exist)

# Check if a username is given
if [ $# -ne 1 ]; then
	echo "Usage:  $0 username"
	exit 65  # 65 = Bad Arguments
fi

# Check if the user already exists
if (id $1 > /dev/null); then
	echo "Error: User \"$1\" already exists."
	exit 1
fi

mkdir -p /opt/www/$1/www
adduser --home /opt/www/$1 --shell /bin/false --no-create-home --ingroup sftpusers --disabled-login $1

# Check if creating the user was successful. delete the dirs if not.
if (id $1 > /dev/null); then
	echo
	echo -e "\e[32mUser \"$1\" created successfully \e[0m"
	
	cd /opt/www/$1
	touch php-fpm-error.log nginx-erorr.log nginx-access.log
	mkdir tmp
	chown -R $1:sftpusers ./
	mkdir -p usr/share
	mkdir etc
	cp /etc/localtime ./etc/
	cp -R /usr/share/zoneinfo/ ./usr/share/zoneinfo/
	cp ../TEMPLATE/* ./	
	mv nginx-server.conf- nginx-server.conf
	mv php-fpm-pool.conf- php-fpm-pool.conf
	sed -i "s/§§USER§§/$1/g" *.conf

	echo -e "\e[32mConfigs created successfully \e[0m"
	echo
	echo -e "\e[1;33mRestart NGINX and PHP-FPM! \e[0m"
	echo
	exit 0
fi

rmdir /opt/www/$i/www
rmdir /opt/www/$i
echo -e "\e[1;31mAn Error occured while creating user \"$1\" \e[0m"
exit 1

