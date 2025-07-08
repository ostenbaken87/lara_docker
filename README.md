Склонировать репозиторий lara_docker, создать в нем папку src, в нее установить laravel. После чего перенести все файлы в корень lara_docker, удалить src.
1. mkdir src
2. cd src
3. composer create-project "laravel/laravel:^10.0" .
4. docker-compose up -d
5. Выполнить все команды:</br>
-docker-compose exec app chown -R www-data:www-data /var/www/storage</br>
-docker-compose exec app chown -R www-data:www-data /var/www/bootstrap/cache</br>
-docker-compose exec app chmod -R 775 /var/www/storage</br>
-docker-compose exec app chmod -R 775 /var/www/bootstrap/cache</br>
6. docker-compose exec app php artisan key:generate - Laravel ключ</br>
7. docker-compose exec app php artisan migrate - Для миграций</br>
8. docker-compose up -d --build - Запуск проекта
