FROM debian:stable-slim

LABEL maintainer="Steven Lucol <lucol.steven@gmail.com>"

ENV NGINX_VERSION 1.16.1
ENV ZLIB_VERSION 1.2.11
ENV PCRE_VERSION 8.43
ENV OPENSSL_VERSION 1.0.2t

#RUN apk update
#RUN apk add ca-certificates
#RUN update-ca-certificates

#init directory
RUN mkdir -p /usr/src && cd /usr/src

#init group
RUN useradd -r -s /bin/false nginx \
&& usermod --shell=/sbin/nologin -G nginx nginx

RUN usermod --shell=/sbin/nologin -G www-data www-data

# install libs

RUN apt update
RUN apt install build-essential -y
RUN apt install wget -y
#RUN apt-get install \
#		gcc \
#		perl \
#		g++\
#		libc-dev \
#		make

# install openssl
RUN cd /usr/src && wget http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
&& tar -zxf openssl-${OPENSSL_VERSION}.tar.gz \
&& cd openssl-${OPENSSL_VERSION} \
&& ./config \
&& make \
&&  make install

# install PCRE
RUN cd /usr/src && wget https://sourceforge.net/projects/pcre/files/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.gz/download \
&& tar -zxf download \
&& cd pcre-${PCRE_VERSION} \
&& ./configure \
&& make \
&& make install

#install zlib
RUN cd /usr/src && wget http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz \
&& tar -zxf zlib-${ZLIB_VERSION}.tar.gz \
&& cd zlib-${ZLIB_VERSION} \
&& ./configure \
&& make \
&& make install

RUN cd /usr/src && ls -la openssl-${OPENSSL_VERSION}
#install nginx
RUN cd /usr/src && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
&& tar zxf nginx-${NGINX_VERSION}.tar.gz \
&& cd nginx-${NGINX_VERSION} \
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
--with-pcre=../pcre-${PCRE_VERSION} \
--with-zlib=../zlib-${ZLIB_VERSION} \
--with-openssl=../openssl-${OPENSSL_VERSION} \
--with-http_ssl_module \
--with-http_v2_module \
--with-threads \
&& make -j$(getconf _NPROCESSORS_ONLN) \
&& make install

RUN mkdir -p /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/conf.d
RUN mkdir -p /var/cache/nginx/client_temp

#RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf
RUN echo "upstream php-upstream { server drupal:9000; }" >> /etc/nginx/conf.d/upstream.conf


ADD nginx.conf /etc/nginx/
#ADD symfony.conf /etc/nginx/sites-available/
ADD drupal.conf /etc/nginx/sites-available/
#ADD node.conf /etc/nginx/sites-available/

#RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN ln -s /etc/nginx/sites-available/drupal.conf /etc/nginx/sites-enabled/drupal
#RUN ln -s /etc/nginx/sites-available/node.conf /etc/nginx/sites-enabled/node


RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html

RUN echo 'alias ll="ls -la"' >> ~/.bashrc
RUN apt-get install vim -y

RUN usermod --shell=/sbin/nologin -G www-data www-data

CMD ["nginx"]

RUN ls -la /var/www/html
RUN nginx -v