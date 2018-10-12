# docker-php7-fpm
Infra image for php7-fpm@alpine that supports optional xdebug

##Running with xdebug

By default php and php-fpm will run without xdebug enabled. To use xdebug you must use a custom configfile:

```
1cafb003b5e1:/opt/app-root# php-fpm7 -m | grep xdebug
1cafb003b5e1:/opt/app-root# php-fpm7 -c /etc/php7/php_xdebug.ini  -m | grep xdebug
xdebug
1cafb003b5e1:/opt/app-root# php -m | grep xdebug
1cafb003b5e1:/opt/app-root# php -c /etc/php7/php_xdebug.ini  -m | grep xdebug
xdebug
```

For development activities you must overload a default commandline for this container.
