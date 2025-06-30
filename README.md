Склонировать репозиторий lara_docker, создать в нем папку src, в нее установить laravel. После чего перенести все файлы в корень lara_docker, удалить src.
1. mkdir src
4. cd src
5. composer create-project "laravel/laravel:^10.0" .
6. docker-compose up -d
7. docker-compose exec app chown -R www-data:www-data /var/www/storage
   docker-compose exec app chown -R www-data:www-data /var/www/bootstrap/cache
   docker-compose exec app chmod -R 775 /var/www/storage
   docker-compose exec app chmod -R 775 /var/www/bootstrap/cache
6.docker-compose exec app php artisan key:generate - Laravel ключ
7.docker-compose exec app php artisan migrate - Для миграций
8.docker-compose up -d --build - Запуск проекта
