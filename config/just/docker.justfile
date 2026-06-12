set shell := ["bash", "-uc"]

# показать список команд
default:
    @just --list

# поднять стек (compose up -d)
up:
    docker compose up -d

# остановить стек (compose down)
down:
    docker compose down

# пересоздать контейнеры без кэша
recreate:
    docker compose up -d --force-recreate

# обновить образы и поднять
update:
    docker compose pull && docker compose up -d

# логи (follow, последние N строк):  just logs 50
logs tail="100":
    docker compose logs -f --tail={{tail}}

# статус контейнеров
ps:
    docker compose ps

# shell внутри сервиса:  just sh app
sh service:
    docker compose exec {{service}} sh
