## Utility functions

# mkdir + cd in one step
mkcd() {
    mkdir -p "$1" && builtin cd "$1"
}

# Extract any archive
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

# Show PATH entries one per line
path() {
    echo "$PATH" | tr ':' '\n'
}

# docker compose logs с кастомным tail:  dlogs 50
dlogs() {
    docker compose logs -f --tail="${1:-100}"
}

# docker compose exec shell:  dsh app
dsh() {
    docker compose exec "$1" sh
}

# git: первый коммит + пуш:  ship "msg"
ship() {
    git add -A && git commit -m "${1:-initial commit}" && git push -u origin HEAD
}

# git: быстрый коммит всего:  save "msg"
save() {
    git add -A && git commit -m "$1"
}

# git: pull --rebase --autostash
gsync() {
    git pull --rebase --autostash
}
