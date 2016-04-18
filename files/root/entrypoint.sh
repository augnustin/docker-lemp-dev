#!/bin/bash

echo 'Change wp-config.php with'
echo 'USERNAME: root'
echo 'PASSWORD: root'
echo 'DB_NAME: docker'
echo 'DB_HOST: 127.0.0.1'

set -e

service mysql start
service nginx restart
service php5-fpm restart

mysql -u'root' -p'root' -e 'create database docker'
mysql -h '127.0.0.1' -u'root' -p'root' 'docker' < 'discosoumod1.sql'

# exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
