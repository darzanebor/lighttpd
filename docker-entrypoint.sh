#!/bin/sh
config='/etc/lighttpd/lighttpd.conf'
chown -R lighttpd:lighttpd /var/run/lighttpd /var/log/lighttpd /var/cache/lighttpd
while [ ! -f $config ]
do
  sleep 5
done
lighttpd -D -f $config