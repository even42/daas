FROM php:7.3-fpm
ARG TIMEZONE

LABEL maintainer="Steven Lucol <lucol.steven@gmail.com>"

RUN apt-get update && apt-get install -y \
    openssl \
    git \
    libfreetype6-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libjpeg-dev \
    libpq-dev \
    libzip-dev \
    unzip



# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
RUN "date"

# Type docker-php-ext-install to see available extensions
#RUN docker-php-ext-install pdo pdo_mysql opcache
#RUN docker-php-ext-install mbstring mysqli gd


RUN	docker-php-ext-configure gd \
		--with-freetype-dir=/usr \
		--with-jpeg-dir=/usr \
		--with-png-dir=/usr

RUN docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		mbstring \
		mysqli \
		pdo_mysql \
		pdo_pgsql \
		zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini
# install xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN apt-get install vim -y

RUN echo 'alias ll="ls -la"' >> ~/.bashrc

RUN mkdir -p /var/ww/html


WORKDIR /var/www/html/daas
ADD scripts ./scripts
ADD composer.json composer.json
RUN composer install
RUN cd /var/www/html && ls -la
#RUN chown -R www-data:www-data /var/www/html