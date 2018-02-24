#!/bin/sh

# Set attachment size and memory limit
sed -i -e "s/<UPLOAD_MAX_SIZE>/25M/g" /nginx/conf/nginx.conf /php/etc/php-fpm.conf \
       -e "s/<MEMORY_LIMIT>/128M/g" /php/etc/php-fpm.conf
	   
# Check Required Variables.
if [ -z ${MYSQL_HOST} ]; then
        echo "MySQL Hostname not set!"
        exit 1
fi
if [ -z ${MYSQL_PORT} ]; then
        echo "MySQL Port not set!"
        exit 1
fi
if [ -z ${MYSQL_USER} ]; then
        echo "MySQL Username Name not set!"
        exit 1
fi
if [ -z ${MYSQL_PASS} ]; then
        echo "MySQL Password not set!"
        exit 1
fi
if [ -z ${MYSQL_DB} ]; then
        echo "MySQL Database not set!"
        exit 1
fi

DBHOST=${MYSQL_HOST}
DBPORT=${MYSQL_PORT:-3306}
DBUSER=${MYSQL_USER}
DBNAME=${MYSQL_DB:-mangosweb}
DBPASS=${MYSQL_PASS}
NGINX_PORT=${NGINX_PORT:-7788}
DISABLE_INSTALL=${DISABLE_INSTALL:-false}
# Configure MySql Connection
echo "Configuring MySql Connection."
cat > /mangosweb/config/config-protected.php <<EOF
<?php
/****************************************************************************/
/*  						< MangosWeb v4 >  								*/
/*              Copyright (C) <2017> <Mistvale.com>   		                */
/*					  < http://www.mistvale.com >							*/
/*																			*/
/*			Original MangosWeb Enhanced (C) 2010-2011 KeysWow				*/
/*			Original MangosWeb (C) 2007, Sasha, Nafe, TGM, Peec				*/
/****************************************************************************/
\$dbconf = array(
'db_host'         => '${MYSQL_HOST}',
'db_port'         => '${MYSQL_PORT}',
'db_username'     => '${MYSQL_USER}',
'db_password'     => '${MYSQL_PASS}',
'db_name'         => '${MYSQL_DB}',
'db_encoding'     => 'utf8',
);
?>
EOF
echo "MySql Connection Configured."
# Fixing Permissions
chown -R 991:991 /mangosweb /etc/s6.d /nginx /php /var/log

# Configure Nginx Listen Port
echo "Configuring Nginx Listen Port."
sed -i "s/7788/${NGINX_PORT}/g" /nginx/sites-enabled/mangosweb.conf
echo "Nginx Listen Port Configured."
echo "Server is now started."
echo "mangosweb is listening on port: ${NGINX_PORT}"

# Checking Install
if [ ${DISABLE_INSTALL} == "true" ]; then
        echo "Disabling Installer!"
        rm -rf /mangosweb/install/* /mangosweb/install /mangosweb/update/* /mangosweb/update
fi
# RUN !
exec su-exec 991:991 /bin/s6-svscan /etc/s6.d
