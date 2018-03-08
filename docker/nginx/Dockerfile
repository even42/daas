FROM alpine:3.5

LABEL maintainer="Steven Lucol <lucol.steven@gmail.com>"

ENV NGINX_VERSION 1.13.8
ENV ZLIB_VERSION 1.2.11
ENV PCRE_VERSION 8.41
ENV OPENSSL_VERSION 1.0.2n

RUN apk update && apk add ca-certificates wget && update-ca-certificates

#init directory
RUN mkdir -p /usr/src && cd /usr/src

#init group
RUN addgroup -S nginx \
&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx

# install libs
RUN apk add --no-cache --virtual .build-deps \
		gcc \
		perl \
		g++\
		libc-dev \
		make

# install openssl
RUN cd /usr/src && wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz \
&& tar -zxf openssl-$OPENSSL_VERSION.tar.gz \
&& cd openssl-$OPENSSL_VERSION \
&& ./config \
&& make \
&&  make install

# install PCRE
RUN cd /usr/src && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$PCRE_VERSION.tar.gz \
&& tar -zxf pcre-$PCRE_VERSION.tar.gz \
&& cd pcre-$PCRE_VERSION \
&& ./configure \
&& make \
&& make install

#install zlib
RUN cd /usr/src && wget http://zlib.net/zlib-$ZLIB_VERSION.tar.gz \
&& tar -zxf zlib-$ZLIB_VERSION.tar.gz \
&& cd zlib-$ZLIB_VERSION \
&& ./configure \
&& make \
&& make install

#install nginx
RUN cd /usr/src && wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz \
&& tar zxf nginx-$NGINX_VERSION.tar.gz \
&& cd nginx-$NGINX_VERSION \
&& ./configure \
--user=www-data \
--group=www-data \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--modules-path=/usr/lib/nginx/modules \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--with-pcre=../pcre-$PCRE_VERSION \
--with-zlib=../zlib-$ZLIB_VERSION \
--with-openssl=../openssl-$OPENSSL_VERSION \
--with-http_ssl_module \
--with-http_v2_module \
--with-threads \
&& make -j$(getconf _NPROCESSORS_ONLN) \
&& make install

RUN mkdir -p /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/conf.d

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1


ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/
ADD drupal.conf /etc/nginx/sites-available/
ADD node.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN ln -s /etc/nginx/sites-available/drupal.conf /etc/nginx/sites-enabled/drupal
RUN ln -s /etc/nginx/sites-available/node.conf /etc/nginx/sites-enabled/node

CMD ["nginx"]

RUN ls -la /etc/nginx/

