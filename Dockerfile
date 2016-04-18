FROM ubuntu:latest

## Install php nginx mysql supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get install -y php5 php5-cgi php5-fpm php5-cli php5-gd php5-mcrypt php5-mysql php5-curl \
             nginx \
             curl \
         supervisor && \
  echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
  echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

## Configuration
RUN sed -i 's/^listen\s*=.*$/listen = 127.0.0.1:9000/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = \/var\/log\/php5\/cgi.log/' /etc/php5/fpm/php.ini && \
  sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = \/var\/log\/php5\/cli.log/' /etc/php5/cli/php.ini && \
  sed -i 's/^key_buffer\s*=/key_buffer_size =/' /etc/mysql/my.cnf

COPY files/root /

RUN service mysql start && \
  echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect ' | debconf-set-selections && \
  echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections && \
  echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections && \
  echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin

WORKDIR /var/www/

VOLUME /var/www/

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
