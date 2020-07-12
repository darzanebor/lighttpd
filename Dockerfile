FROM alpine:3.11.5
RUN apk update && \
    apk add --no-cache nano lighttpd curl
RUN apk add --no-cache lighttpd \
    php7-common \
    php7-iconv \
    php7-json \
    php7-gd \
    php7-curl \
    php7-xml \
    php7-mysqli \
    php7-imap \
    php7-cgi \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom \
    fcgi && \
    mkdir /var/run/lighttpd /var/cache/lighttpd && \
    mkdir /var/cache/lighttpd/uploads
RUN chown -R lighttpd:lighttpd /var/www /var/run/lighttpd /var/log/lighttpd /var/cache/lighttpd && \
    chmod -R 550 /var/www && \
    chmod -R 750 /var/log/lighttpd /var/cache/lighttpd /var/run/lighttpd && \
    rm -rf /var/www/localhost && \
    echo "Hello world!" > /var/www/index.html
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
    rm -rf /var/cache/apk/*
WORKDIR /var/www
#USER lighttpd
EXPOSE 8080/tcp 8443/tcp
ENTRYPOINT [ "/docker-entrypoint.sh" ]
