## cheat / dothelp — quick reference for installed tools

cheat() {
    local BOLD='\033[1m'
    local CYAN='\033[0;36m'
    local GREEN='\033[0;32m'
    local YELLOW='\033[1;33m'
    local DIM='\033[2m'
    local NC='\033[0m'

    printf "\n${BOLD}${CYAN}СОВРЕМЕННЫЕ УТИЛИТЫ${NC}\n"
    printf "${DIM}%-10s  %-18s  %-34s  %s${NC}\n" "КОМАНДА" "ВМЕСТО" "ЧТО ДЕЛАЕТ" "ПРИМЕР"
    printf "${DIM}%s${NC}\n" "──────────────────────────────────────────────────────────────────────────────────"

    _crow() {
        printf "  ${GREEN}%-10s${NC}  ${DIM}→ %-16s${NC}  %-34s  ${YELLOW}%s${NC}\n" "$1" "$2" "$3" "$4"
    }

    _crow "ll / la / lt"  "ls"      "список файлов (long/all/tree)"      "la   /   lt --level=3"
    _crow "bat"           "cat"     "просмотр с подсветкой синтаксиса"   "bat file.go"
    _crow "fd"            "find"    "поиск файлов, простой синтаксис"    "fd -e go report"
    _crow "rg"            "grep"    "быстрый поиск по коду"              "rg TODO ./src"
    _crow "fzf"           "-"       "fuzzy-поиск: Ctrl+R, Ctrl+T"       "history | fzf"
    _crow "z / zi"        "cd"      "умный переход (запоминает пути)"    "z dotfiles"
    _crow "btop"          "top/htop" "монитор CPU/RAM/сети"              "btop"
    _crow "tldr"          "man"     "краткие примеры по командам"        "tldr tar"
    _crow "delta"         "diff"    "красивые git diff"                  "git diff  (авто)"
    _crow "tmux"          "screen"  "мультиплексор: Ctrl+b prefix"       "tmux new / tmux attach"
    _crow "j / just"      "make"    "запуск задач (justfile)"            "j  /  just --list"

    printf "\n${BOLD}TMUX биндинги${NC}  ${DIM}(prefix = Ctrl+b)${NC}\n"
    printf "  prefix + ${YELLOW}|${NC}   вертикальный сплит\n"
    printf "  prefix + ${YELLOW}-${NC}   горизонтальный сплит\n"
    printf "  prefix + ${YELLOW}r${NC}   перезагрузить конфиг\n"
    printf "  ${YELLOW}Колёсико мыши${NC} — скролл истории\n"

    printf "\n${BOLD}DOCKER COMPOSE${NC}\n"
    printf "  ${GREEN}dup${NC}   up -d      ${GREEN}ddown${NC}  down          ${GREEN}dre${NC}   force-recreate\n"
    printf "  ${GREEN}dupd${NC}  pull+up    ${GREEN}dps${NC}   ps            ${GREEN}dlogs${NC} [N]  logs -f\n"
    printf "  ${GREEN}dsh${NC}   <service>  exec shell\n"

    printf "\n${BOLD}GIT ФУНКЦИИ${NC}\n"
    printf "  ${GREEN}ship${NC} \"msg\"  add -A + commit + push   ${GREEN}save${NC} \"msg\"  add -A + commit\n"
    printf "  ${GREEN}gsync${NC}        pull --rebase\n"

    printf "\n${BOLD}АЛИАСЫ${NC}  ${DIM}полный список: alias${NC}\n"
    printf "  ${GREEN}g${NC}=git  ${GREEN}j${NC}=just  ${GREEN}dc${NC}=docker compose  ${GREEN}md${NC}=mkdir -p  ${GREEN}please${NC}=sudo !!\n"
    printf "  ${GREEN}..${NC}  ${GREEN}...${NC}  ${GREEN}....${NC} — переходы вверх\n"
    printf "  ${GREEN}reload${NC} — перезапустить shell  ${GREEN}dotfiles${NC} — перейти в ~/.dotfiles\n"

    printf "\n${DIM}Эта справка: cheat  или  dothelp${NC}\n\n"
}

alias dothelp='cheat'
