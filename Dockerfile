FROM circleci/php:7.1-stretch-node-browsers

RUN echo "deb http://mirrors.kernel.org/ubuntu/ xenial main" | sudo tee -a /etc/apt/sources.list \
&& apt-get update && apt-get install -y \
  zlib1g-dev \
  libsqlite3-dev \
  mysql-client \
  libxml2-dev \
  libmcrypt-dev \
  libreadline-dev \
  imagemagick \
  libmagickcore-dev \
  libmagickwand-dev \
&& apt-get install -y --allow-unauthenticated libpng12-0 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure intl && docker-php-ext-install intl 
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install zip 
RUN docker-php-ext-install soap
RUN docker-php-ext-install mbstring 
RUN docker-php-ext-install pdo_mysql
RUN pecl install mongodb && docker-php-ext-enable mongodb 
RUN pecl install imagick && docker-php-ext-enable imagick

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]