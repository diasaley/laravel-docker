FROM php:8.1.2-fpm-alpine

# enviroment variable
ENV \
	APP_DIR="/webapp" \
	APP_PORT="8001"

# memindahkan file atau folder ke driektori yang di inginkan di docker
COPY . $APP_DIR
COPY .env.example $APP_DIR/.env

# menginstall kebutuhnan yang ingin digunakna
RUN apk add --update \
	curl \
	php \
	php-opcache \
	php-openssl \
	php-pdo \
	php-json \
	php-phar \
	php-dom \
	&& rm -rf /var/cache/apk/*
	
# menginstall composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/bin --filename=composer

# menjalankna perintah composer
RUN cd $APP_DIR && composer update
RUN cd $APP_DIR && php artisan key:generate

# entrypoin
WORKDIR $APP_DIR 

# menjaankan apikasi 
CMD ["sh", "-c", "php artisan serve --host=0.0.0.0 --port=${APP_PORT}"]

# run composer update
RUN composer update

# akses 
EXPOSE $APP_PORT


