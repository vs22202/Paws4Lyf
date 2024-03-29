FROM php:8.2-cli

RUN apk update && apk add build-base

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN apk add zlib-dev git zip \
  && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/ \
  && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

COPY . /app
WORKDIR /app

RUN composer install --prefer-source --no-interaction

ENV PATH="~/.composer/vendor/bin:./vendor/bin:${PATH}"



