FROM alpine:3.14
ENV LIGHTTPD_CONF=''
RUN apk update && \
    apk add --no-cache nano lighttpd curl \
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
    fcgi
ADD error /var/www/error
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
RUN mkdir /run/lighttpd /var/cache/lighttpd /var/cache/lighttpd/uploads && \
    echo "Hello world!" > /var/www/index.html && \
    chown -R lighttpd:lighttpd /etc/lighttpd /var/www /run/lighttpd /var/cache/lighttpd && \
    chmod -R 750 /var/www /var/cache/lighttpd /run/lighttpd && \
    sed -i -r 's|.*cgi.fix_pathinfo=.*|cgi.fix_pathinfo=1|g' /etc/php*/php.ini  && \
    sed -i -r 's#.*safe_mode =.*#safe_mode = Off#g' /etc/php*/php.ini  && \
    sed -i -r 's#.*expose_php =.*#expose_php = Off#g' /etc/php*/php.ini  && \
    sed -i -r 's#memory_limit =.*#memory_limit = 536M#g' /etc/php*/php.ini  && \
    sed -i -r 's#upload_max_filesize =.*#upload_max_filesize = 128M#g' /etc/php*/php.ini  && \
    sed -i -r 's#post_max_size =.*#post_max_size = 256M#g' /etc/php*/php.ini  && \
    sed -i -r 's#^file_uploads =.*#file_uploads = On#g' /etc/php*/php.ini  && \
    sed -i -r 's#^max_file_uploads =.*#max_file_uploads = 12#g' /etc/php*/php.ini  && \
    sed -i -r 's#^allow_url_fopen = .*#allow_url_fopen = On#g' /etc/php*/php.ini  && \
    sed -i -r 's#^.default_charset =.*#default_charset = "UTF-8"#g' /etc/php*/php.ini  && \
    sed -i -r 's#^.max_execution_time =.*#max_execution_time = 150#g' /etc/php*/php.ini  && \
    sed -i -r 's#^max_input_time =.*#max_input_time = 90#g' /etc/php*/php.ini
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
    rm -rf /var/www/localhost && \
    rm -rf /var/cache/apk/*
WORKDIR /var/www
EXPOSE 8080/tcp 8443/tcp
USER lighttpd
ENTRYPOINT [ "/docker-entrypoint.sh" ]
