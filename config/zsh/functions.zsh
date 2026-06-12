## Functions

## Файлы
# mkdir + cd в один шаг:  mkcd mydir
mkcd() {
    mkdir -p "$1" && builtin cd "$1"
}

# распаковать любой архив:  extract file.tar.gz
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1"   ;;
            *.tar.gz)  tar xzf "$1"   ;;
            *.tar.xz)  tar xJf "$1"   ;;
            *.tar)     tar xf "$1"    ;;
            *.bz2)     bunzip2 "$1"   ;;
            *.gz)      gunzip "$1"    ;;
            *.zip)     unzip "$1"     ;;
            *.7z)      7z x "$1"      ;;
            *)         echo "Unknown format: $1" ;;
        esac
    else
        echo "File not found: $1"
    fi
}

## Система
# показать PATH построчно
path() {
    echo "$PATH" | tr ':' '\n'
}

## Docker Compose
# логи с кастомным tail:  dlogs 50
dlogs() {
    docker compose logs -f --tail="${1:-100}"
}

# exec shell внутри сервиса:  dsh app
dsh() {
    docker compose exec "$1" sh
}

## Git
# первый коммит + пуш:  ship "msg"
ship() {
    git add -A && git commit -m "${1:-initial commit}" && git push -u origin HEAD
}

# быстрый коммит всего:  save "msg"
save() {
    git add -A && git commit -m "$1"
}

# pull --rebase --autostash
gsync() {
    git pull --rebase --autostash
}
