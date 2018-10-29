FROM circleci/php:7.1-stretch-node-browsers

RUN echo "deb http://mirrors.kernel.org/ubuntu/ xenial main" | sudo tee -a /etc/apt/sources.list \
&& sudo apt-get update && sudo apt-get install -y --allow-unauthenticated \
  zlib1g-dev \
  libsqlite3-dev \
  mysql-client \
  libxml2-dev \
  libmcrypt-dev \
  libreadline-dev \
  imagemagick \
  libmagickcore-dev \
  libmagickwand-dev \
&& sudo apt-get install -y --allow-unauthenticated libpng12-0

RUN sudo docker-php-ext-configure intl && sudo docker-php-ext-install intl 
RUN sudo docker-php-ext-install mcrypt
RUN sudo docker-php-ext-install zip 
RUN sudo docker-php-ext-install soap
RUN sudo docker-php-ext-install mbstring 
RUN sudo docker-php-ext-install pdo_mysql
RUN sudo docker-php-ext-install gd
RUN sudo pecl install mongodb && sudo docker-php-ext-enable mongodb 
RUN sudo pecl install imagick && sudo docker-php-ext-enable imagick

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]
