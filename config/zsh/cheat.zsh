## cheat / dothelp — quick reference for installed tools

# Parse aliases.zsh / functions.zsh: ## Group headers + alias/function lines
_cheat_parse_file() {
    local file="$1"
    [[ -f "$file" ]] || return
    local BOLD='\033[1m' GREEN='\033[0;32m' DIM='\033[2m' NC='\033[0m'
    local desc=""
    while IFS= read -r line; do
        # Group header
        if [[ "$line" == "## "* ]]; then
            printf "\n  ${BOLD}${line:3}${NC}\n"
            desc=""
        # Inline description — store for next function
        elif [[ "$line" == "# "* ]]; then
            desc="${line:2}"
        # Alias: alias name='value'
        elif [[ "$line" == "alias "* ]]; then
            local rest="${line:6}"
            local name="${rest%%=*}"
            local val="${rest#*=}"
            val="${val//\'/}"
            val="${val//\"/}"
            printf "    ${GREEN}%-20s${NC}${DIM}%s${NC}\n" "$name" "$val"
            desc=""
        # Function definition: name() {
        elif [[ "$line" =~ '^([a-zA-Z_][a-zA-Z0-9_-]*)\(\)' ]]; then
            printf "    ${GREEN}%-20s${NC}${DIM}%s${NC}\n" "${match[1]}()" "$desc"
            desc=""
        fi
    done < "$file"
}

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

    _crow "ll / la / lt"  "ls"       "список файлов (long/all/tree)"      "la   /   lt --level=3"
    _crow "bat"           "cat"      "просмотр с подсветкой синтаксиса"   "bat file.go"
    _crow "fd"            "find"     "поиск файлов, простой синтаксис"    "fd -e go report"
    _crow "rg"            "grep"     "быстрый поиск по коду"              "rg TODO ./src"
    _crow "fzf"           "-"        "fuzzy-поиск: Ctrl+R, Ctrl+T"       "history | fzf"
    _crow "z / zi"        "cd"       "умный переход (запоминает пути)"    "z dotfiles"
    _crow "btop"          "top/htop" "монитор CPU/RAM/сети"               "btop"
    _crow "tldr"          "man"      "краткие примеры по командам"        "tldr tar"
    _crow "delta"         "diff"     "красивые git diff"                  "git diff  (авто)"
    _crow "tmux"          "screen"   "мультиплексор: Ctrl+b prefix"       "tmux new / tmux attach"
    _crow "j / just"      "make"     "запуск задач (justfile)"            "j  /  just --list"
    _crow "nvim"          "vim"      "редактор: LSP + дерево + telescope"  "<Space>ff файлы"

    printf "\n${BOLD}NVIM биндинги${NC}  ${DIM}(leader = Space)${NC}\n"
    printf "  ${YELLOW}<Space>ff${NC}  файлы      ${YELLOW}<Space>fg${NC}  поиск текста   ${YELLOW}<Space>fb${NC}  буферы\n"
    printf "  ${YELLOW}<Space>e${NC}   дерево     ${YELLOW}<Space>ca${NC}  code action    ${YELLOW}<Space>cf${NC}  форматировать\n"
    printf "  ${YELLOW}gd${NC}        определение  ${YELLOW}K${NC}         документация    ${YELLOW}<Space>rn${NC}  rename\n"

    printf "\n${BOLD}TMUX биндинги${NC}  ${DIM}(prefix = Ctrl+b)${NC}\n"
    printf "  prefix + ${YELLOW}|${NC}   вертикальный сплит\n"
    printf "  prefix + ${YELLOW}-${NC}   горизонтальный сплит\n"
    printf "  prefix + ${YELLOW}r${NC}   перезагрузить конфиг\n"
    printf "  ${YELLOW}Колёсико мыши${NC} — скролл истории\n"

    printf "\n${BOLD}${CYAN}АЛИАСЫ И ФУНКЦИИ${NC}\n"
    _cheat_parse_file "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.zsh"
    _cheat_parse_file "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.zsh"

    printf "\n${DIM}Эта справка: cheat  или  dothelp${NC}\n\n"
}

alias dothelp='cheat'
