#!/bin/sh
#
# MAGENTO PHP SETUP
#
# PHP-FPM on ALPINE
#

# exit if a command fails
set -e

# Updating repo
apk apk update

# Installing
# Dependencies for PHP extensions
apk add freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libedit-dev libxml2-dev curl-dev
# Dependencies for compile gd
apk add m4 perl autoconf libmagic file libgcc libstdc++ binutils-libs binutils gmp libgomp libatomic mpfr3 gcc musl-dev libc-dev g++ make re2c libmcrypt-dev

# Compiling gd
docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

# Installing PHP extensions
docker-php-ext-install \
    gd iconv opcache readline soap xml mysqli curl json openssl curl mbstring zip

# Installing redis and Xdebug
pecl install redis
pecl install xdebug
docker-php-ext-enable redis xdebug

# Removing unused binaries
apk del m4 perl autoconf libmagic file libgcc libstdc++ binutils-libs binutils gmp libgomp libatomic mpfr3 gcc musl-dev libc-dev g++ make re2c libmcrypt-dev

# Set Workdir
cd /var/www/html