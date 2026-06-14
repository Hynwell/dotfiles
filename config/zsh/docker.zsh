## Docker Compose — алиасы + функции

alias dc='docker compose'
alias dup='docker compose up -d && docker compose logs -tf'
alias ddown='docker compose down'
alias dre='docker compose up -d --force-recreate && docker compose logs -tf'
alias dupd='docker compose pull && docker compose up -d'
alias dps='docker compose ps'

# логи с кастомным tail:  dlogs 50
dlogs() {
    docker compose logs -f --tail="${1:-100}"
}

# зайти в контейнер: bash если есть, иначе sh:  dsh app
dsh() {
    docker compose exec -it "$1" bash 2>/dev/null || docker compose exec -it "$1" sh
}
