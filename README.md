# FineBI 6.1 — Docker-стенд

Стенд FineBI 6.1.4 (FanRuan) для демонстрации, обучения и разработки.

## Архитектура

```
                        ┌─────────────────────────────────┐
                        │         Docker Compose           │
 http://localhost:37799 │                                  │
 ─────────────────────► │  nginx (:80) ──► finebi (:37799) │
                        │                      │           │
 http://localhost:37800 │                      │           │
 ─────────────────────► │  (direct Tomcat) ────┘           │
                        │                                  │
 localhost:37798        │  finedb (MySQL 8.0, :3306)       │
 ─────────────────────► │                                  │
                        └─────────────────────────────────┘
```

Nginx перед Tomcat — приближение к реальной конфигурации production-деплоев FineBI
(FineOPS, Docker Swarm, Kubernetes). Прямой доступ к Tomcat (порт 37800) оставлен
для отладки.

| Сервис | Порт | Назначение |
|--------|------|------------|
| nginx  | 37799 | Основная точка входа (reverse proxy) |
| finebi | 37800 | Прямой доступ к Tomcat (отладка) |
| finedb | 37798 | Прямой доступ к MySQL (отладка) |

## Быстрый старт

```bash
docker compose up -d
```

Дождитесь инициализации FineBI (~30–60 сек), затем откройте:

**http://localhost:37799/webroot/decision**

### Первоначальная настройка

При первом запуске FineBI попросит создать администратора и настроить хранилище.

1. **Администратор:** `admin` / `admin` (или по вашему выбору)
2. **External Database** (FineDB):

   | Параметр | Значение |
   |----------|----------|
   | Database Type | MySQL |
   | Host | `finedb` |
   | Port | `3306` |
   | Database Name | `finedb` |
   | Username | `finebi` |
   | Password | `finebi` |

## Управление

```bash
docker compose up -d      # Запуск
docker compose stop        # Остановка (данные сохраняются)
docker compose start       # Повторный запуск
docker compose down        # Удаление контейнеров (volumes сохраняются)
docker compose down -v     # Полный сброс (удаляет все данные!)
```

## Сборка образа из дистрибутива

Готовый образ `ddmitry80/finebi:6.1.4.01-centos` доступен на Docker Hub.
Для сборки своего образа:

1. Скачайте Linux-дистрибутив FineBI с https://intl.finebi.com/download
2. Положите `.sh`-файл в каталог проекта, обновите имя в `Dockerfile` (`COPY ...`)
3. Раскомментируйте `build: .` в `docker-compose.yml`
4. `docker compose up -d --build`

## Прямой доступ к FineDB

```bash
# Через CLI
mysql -h 127.0.0.1 -P 37798 -u finebi -pfinebi finedb

# Или из контейнера
docker exec -it finedb mysql -u finebi -pfinebi finedb
```
