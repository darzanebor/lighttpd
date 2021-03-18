#!/bin/sh
CONF="${LIGHTTPD_CONF:-/etc/lighttpd/lighttpd.conf}"
chown -R lighttpd:lighttpd /var/run/lighttpd /var/log/lighttpd /var/cache/lighttpd
while [ ! -f $CONF ]
do
  sleep 5
done
lighttpd -D -f $CONF
