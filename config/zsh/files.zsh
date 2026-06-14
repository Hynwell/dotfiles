## Файлы и поиск — алиасы + функции

## ls → eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lta='eza --tree --level=2 --icons -a'

## cat → bat
alias cat='bat --paging=never'

## grep → ripgrep
alias grep='rg'

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
