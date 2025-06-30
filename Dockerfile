FROM php:8.2-fpm-alpine

# Установка зависимостей (apk вместо apt-get)
RUN apk add --no-cache --update \
    build-base \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    libxml2-dev \
    postgresql-dev \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    npm \
    # Для gd:
    freetype \
    libjpeg-turbo \
    # Для composer:
    openssl \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-enable opcache

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Создаем необходимые папки
RUN mkdir -p /var/www/storage /var/www/bootstrap/cache

# Настройка прав
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

# Установка Node.js (в Alpine npm идет вместе с node)
RUN npm install -g npm@latest

WORKDIR /var/www

# Копируем только composer.json сначала
COPY composer.json .
RUN composer install --no-scripts --no-autoloader --no-dev

# Копируем остальные файлы
COPY . .

# Генерация autoload и оптимизация
RUN composer dump-autoload --optimize \
    && chown -R www-data:www-data /var/www
