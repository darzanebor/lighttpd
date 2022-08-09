FROM alphaceti/default-alpine:0.1.7
ENV LIGHTTPD_CONF=''
RUN apk add --update --no-cache \
    lighttpd \
    php8-common \
    php8-iconv \
    php8-json \
    php8-gd \
    php8-curl \
    php8-xml \
    php8-mysqli \
    php8-imap \
    php8-cgi \
    php8-pdo \
    php8-pdo_mysql \
    php8-soap \
    php8-posix \
    php8-gettext \
    php8-ldap \
    php8-ctype \
    php8-dom \
    fcgi
ADD error /var/www/error
RUN mkdir /run/lighttpd /var/cache/lighttpd /var/cache/lighttpd/uploads && \
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
    sed -i -r 's#^max_input_time =.*#max_input_time = 90#g' /etc/php*/php.ini && \
    echo "Hello world!" > /var/www/index.html
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
    rm -rf /var/www/localhost && \
    rm -rf /var/cache/apk/*
WORKDIR /var/www
EXPOSE 8080/tcp 8443/tcp
USER lighttpd
ENTRYPOINT [ "/docker-entrypoint.sh" ]
