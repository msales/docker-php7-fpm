#!/bin/sh


XDEBUG=${XDEBUG:-false}
XDEBUG_HOST=${XDEBUG_HOST:-"host.msales-dev"}
XDEBUG_PORT=${XDEBUG_PORT:-"9001"}


[[ "$USER_ID" ]] || USER_ID=$(id -u)

cat /etc/passwd > /opt/sys/passwd
if [ $USER_ID -ne 0 ] ; then
	echo "== nsswrapper"
	export USER_ID=$(id -u)
	export GROUP_ID=$(id -g)
	export NSS_WRAPPER_PASSWD=/opt/sys/passwd
	export NSS_WRAPPER_GROUP=/etc/group


	echo "${USER_NAME}:x:${USER_ID}:${GROUP_ID}::${USER_HOME}:/sbin/nologin" >> /opt/sys/passwd

	export LD_PRELOAD=/usr/lib/libnss_wrapper.so

fi

if [ "${XDEBUG}" == "true" ]; then
	echo "== Enabling xdebug"
	echo 'zend_extension=xdebug.so' > /etc/php7/conf.d/xdebug.ini
	cp /msales/xdebug.so /usr/lib/php7/modules/xdebug.so
	cp /msales/xdebug.ini /etc/php7/conf.d/
	sed s/__PORT__/${XDEBUG_PORT}/g -i /etc/php7/conf.d/xdebug.ini
	sed s/__HOST__/${XDEBUG_HOST}/g -i /etc/php7/conf.d/xdebug.ini
fi

trapIt () { "$@"& pid="$!"; trap "kill -INT $pid" INT TERM; while kill -0 $pid > /dev/null 2>&1; do wait $pid; ec="$?"; done; exit $ec;};

trapIt "$@"
