FROM msales/alpine-base:3.8

ADD https://getcomposer.org/installer composer-setup.php
ADD https://composer.github.io/installer.sig composer-setup.sig

RUN mkdir /msales \
    && apk add --no-cache \
        gettext \
        curl \
        openssl \
        git \
        php7 \
        php7-bcmath \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fileinfo \
        php7-cgi \
        php7-fpm \
        php7-gd \
        php7-gmp \
        php7-iconv \
        php7-imagick \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_pgsql \
        php7-pdo_mysql \
        php7-phar \
        php7-posix \
        php7-session \
        php7-soap \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zip \
        php7-sockets \
        php7-zlib \
        php7-xdebug \
        php7-pcntl \
        php7-simplexml \
        php7-tokenizer \
        php7-apcu \
        php7-redis \
    && php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) \
      !== trim(file_get_contents('composer-setup.sig'))) \
      { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); } \
      else { echo 'Composer installer checksum is valid.' . PHP_EOL; }" \
    && php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
    && rm -f /etc/php7/conf.d/xdebug.ini

ADD config/php.ini /etc/php7/php.ini
ADD config/php_xdebug.ini /etc/php7/php_xdebug.ini

WORKDIR /opt/app-root

ADD entrypoint.sh /opt/sys/entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/opt/sys/entrypoint.sh" ]
CMD ["php-fpm7", "-F"]
