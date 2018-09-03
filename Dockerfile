FROM msales/alpine-base:3.8

ADD https://getcomposer.org/installer composer-setup.php

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
    && php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
    && rm -f /etc/php7/conf.d/xdebug.ini \
    && mv /usr/lib/php7/modules/xdebug.so /msales/


ADD config/php.ini /etc/php7/php.ini
ADD config/xdebug.ini /msales/xdebug.ini

WORKDIR /opt/app-root

ADD entrypoint.sh /opt/sys/entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/opt/sys/entrypoint.sh" ]
CMD ["php", "-v"]
