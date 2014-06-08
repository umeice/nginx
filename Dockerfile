#
# Nginx & PHP-FPM Dockerfile
#
# https://github.com/umeice/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx
RUN \
  apt-get install -y php5-fpm php5-mysql && \
  apt-get install -y php5-cli mysql-client-5.6

# http://www.tokumaru.org/d/20100927.html
RUN \
  sed -i 's/^;\?\(max_execution_time =\).*$/\1 300/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(memory_limit =\).*$/\1 256M/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(post_max_size =\).*$/\1 32M/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(upload_max_filesize =\).*$/\1 32M/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(date.timezone =\).*$/\1 "Asia\/Tokyo"/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(output_buffering =\).*$/\1 Off/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(default_charset =\).*$/\1 "UTF-8"/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.language =\).*$/\1 Japanese/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.internal_encoding =\).*$/\1 UTF-8/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.http_input =\).*$/\1 UTF-8/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.http_output =\).*$/\1 pass/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.encoding_translation =\).*$/\1 On/' /etc/php5/fpm/php.ini && \
  sed -i 's/^;\?\(mbstring.substitute_character =\).*$/\1 "?"/' /etc/php5/fpm/php.ini


# Define mountable directories.
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
