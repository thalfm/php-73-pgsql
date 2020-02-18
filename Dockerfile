FROM php:7.3.14-fpm

# Instalando extensões necessárias do PHP
#Install libs
RUN apt-get update && apt-get install -y \
        libpq-dev \
        wget \
        unzip \
        libaio1 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libldap2-dev \
        libldb-dev \
        zlib1g-dev \
        libicu-dev g++ \
        libzip-dev \
        zip \
        && docker-php-ext-install -j$(nproc) pdo_pgsql pgsql pdo soap gd intl \
        && docker-php-ext-configure zip \
        && docker-php-ext-install zip \
        && pecl install redis && docker-php-ext-enable redis \
        && docker-php-source delete \
        && apt-get remove -y g++ wget \
        && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* /var/tmp/*

ENV TZ America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone