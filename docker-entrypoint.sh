#!/bin/sh
DEFAULT_CONF='/etc/lighttpd/lighttpd.conf'
CONF="${LIGHTTPD_CONF:-$DEFAULT_CONF}"
chown -R lighttpd:lighttpd /var/run/lighttpd /var/log/lighttpd /var/cache/lighttpd
while [ ! -f $CONF ]
do
  sleep 5
done
lighttpd -D -f $CONF