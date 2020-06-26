#!/bin/sh
config='/etc/lighttpd/lighttpd/lighttpd.conf'
chown -R lighttpd:lighttpd /var/run/lighttpd /var/log/lighttpd /var/cache/lighttpd
#chmod -R 550 /var/www
while [ ! -f $config ]
do
  sleep 5
done
lighttpd -D -f $config