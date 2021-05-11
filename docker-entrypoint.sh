#!/bin/sh
CONF="${LIGHTTPD_CONF:-/etc/lighttpd/lighttpd.conf}"
while [ ! -f $CONF ]
do
  sleep 5
done
lighttpd -D -f $CONF
