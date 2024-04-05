docker-compose.yml и Dockerfile для запуска FineBI

Инициализация контейнеров (в том числе и запуск):
docker-compose up

Или, если нужен запус как постоянного сервиса
docker-compose up -d

Остановка контейнеров:
docker-compose stop

Запуск контейнеров:
docker-compose start

Удаление контейнеров:
docker-compose down

Заходить по url: http://localhost:37799/webroot/decision#/

При первоначальной настройке указать External Database:
Database Type: mysql
Host: finebidb
Port: 3306
Database Name: finedb
Username: finebi
Password: finebi

Если нужно пересобрать контейнер со своими настройками:
- Скачиваем Linux версию FineBI по https://intl.finebi.com/download как linux_unix_FineBI6_0-EN.sh в каталог проекта
- Комментируем в docker-compose.yml строчку c image: для контейнера finebi
- Раскомментируем строчку build . для контейнера finebi
- Правим Dockerfile по своему усмотрению
- `docker-compose up -d --build`
