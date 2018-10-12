#!/bin/sh


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


trapIt () { "$@"& pid="$!"; trap "kill -INT $pid" INT TERM; while kill -0 $pid > /dev/null 2>&1; do wait $pid; ec="$?"; done; exit $ec;};

trapIt "$@"
