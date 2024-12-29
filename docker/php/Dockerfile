FROM php:8.4-fpm

# RUN usermod --non-unique --uid 1000 www-data
# RUN groupmod --non-unique --gid 1000 www-data

RUN mkdir -p /usr/src/php/ext

RUN apt-get -qq update \
    && apt-get install -y apt-utils \
                          xmlsec1 \
                          git \
                          unzip \
                          vim \
                          wget \
                          libzip-dev \
                          libicu-dev \
                          g++ \
                          libmcrypt-dev \
                          libxml2-dev \
                          libbz2-dev \
                          libcurl4 \
                          libcurl4-gnutls-dev \
                          libssl-dev \
                          libgmp-dev \
                          libpcre3-dev\
                          libpq-dev\
                          locales\
                          sqlite3

RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl \
                              zip \
                              calendar \
                              pcntl \
                              bcmath \
                              gmp \
                              exif \
                              bz2


#mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

#RUN docker-php-ext-install pdo_sqlite && docker-php-ext-enable pdo_sqlite

#GD
# RUN apt-get update && apt-get install -y libvpx-dev libjpeg-dev libxpm-dev libpng-dev libfreetype6 libfreetype6-dev
# RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
# RUN docker-php-ext-install gd

#xsl
RUN apt-get update && apt-get install -y libxslt1-dev \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl

#Xdebug
RUN curl https://xdebug.org/files/xdebug-3.4.0.tgz > /tmp/xdebug.tgz \
    && tar -xpzf /tmp/xdebug.tgz \
    && mv xdebug-3.4.0 /usr/src/php/ext \
    && docker-php-ext-install xdebug-3.4.0


# Install composer, this needs to be two steps to ensure we get the latest version
ADD http://getcomposer.org/installer /tmp/installer
RUN php /tmp/installer --install-dir=/usr/local/bin && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

#Install symfony installer
# RUN curl -sS https://get.symfony.com/cli/installer | bash 
# RUN ln -s  /root/.symfony5/bin/symfony /usr/local/bin/symfony
# RUN echo 'export PATH="$HOME/.symfony/bin:$PATH"' >> ~/.bashrc

ADD conf/30-custom.ini /usr/local/etc/php/conf.d/30-custom.ini

#RUN apt-get -y install locales 

# Set the locale
RUN locale-gen es_ES.utf8
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES
#ENV LC_ALL es_ES.utf8

RUN apt-get -y purge

#ENTRYPOINT php-fpm --nodaemonize