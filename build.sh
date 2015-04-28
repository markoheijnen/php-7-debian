#!/bin/bash
cd "$(dirname "$0")"

# Dependencies
apt-get update
apt-get install -y \
    build-essential \
    git-core \
    autoconf \
    bison \
    libxml2-dev \
    libbz2-dev \
    libmcrypt-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libltdl-dev \
    libpng-dev \
    libreadline-dev

mkdir /usr/local/php7

git clone https://github.com/php/php-src.git
cd php-src
./buildconf

CONFIGURE_STRING="--prefix=/usr/local/php7 \
                  --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
                  --enable-bcmath \
                  --with-bz2 \
                  --enable-calendar \
                  --enable-exif \
                  --enable-dba \
                  --with-gettext \
                  --with-gd \
                  --enable-mbstring \
                  --with-mcrypt \
                  --with-mhash \
                  --enable-mysqlnd \
                  --with-mysql=mysqlnd \
                  --with-mysql-sock=/var/run/mysqld/mysqld.sock \
                  --with-mysqli=mysqlnd \
                  --with-pdo-mysql=mysqlnd \
                  --with-openssl \
                  --enable-pcntl \
                  --enable-shmop \
                  --enable-sockets \
                  --enable-sysvmsg \
                  --enable-sysvsem \
                  --enable-sysvshm \
                  --with-zlib \
                  --enable-zip \
                  --with-readline \
                  --with-curl \
                  --enable-fpm \
                  --with-fpm-user=www-data \
                  --with-fpm-group=www-data"

./configure $CONFIGURE_STRING

make
make install
