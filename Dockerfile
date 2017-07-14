FROM php:fpm

RUN apt-get update \
    && apt-get install -y git zlibc zlib1g zlib1g-dev libicu52 libicu-dev g++ libssl-dev libjpeg62-turbo-dev libpng12-dev libfreetype6-dev \
    libmemcached-dev libmcrypt-dev ssh --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure mbstring
RUN docker-php-ext-install mbstring zip intl bcmath pdo_mysql mcrypt iconv mysqli
RUN docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd