FROM php:fpm

RUN apt-get update \
    && apt-get install -y git zlibc zlib1g zlib1g-dev libicu52 libicu-dev g++ libssl-dev \
    libmemcached-dev libmcrypt-dev ssh --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure mbstring
RUN docker-php-ext-install mbstring zip intl bcmath pdo_mysql mcrypt iconv mysqli