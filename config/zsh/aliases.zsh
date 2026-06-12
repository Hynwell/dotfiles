## Aliases

## Файлы — ls → eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lta='eza --tree --level=2 --icons -a'

## Файлы — cat → bat
alias cat='bat --paging=never'

## Поиск — grep → ripgrep
alias grep='rg'

## Навигация
alias cd='z'
alias cdi='zi'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Git
alias g='git'

## Just
alias j='just'

## Docker Compose
alias dc='docker compose'
alias dup='docker compose up -d'
alias ddown='docker compose down'
alias dre='docker compose up -d --force-recreate'
alias dupd='docker compose pull && docker compose up -d'
alias dps='docker compose ps'
# dlogs — функция в functions.zsh (принимает аргумент tail)

## Система
alias top='btop'
alias md='mkdir -p'

## Редактор
if command -v nvim &>/dev/null; then
    alias vim='nvim'
    alias vi='nvim'
fi

## Shell
alias reload='exec zsh'
alias please='sudo $(fc -ln -1)'
alias dotfiles='cd "${DOTFILES_DIR:-$HOME/.dotfiles}"'
alias dotfiles-reload='dotfiles && git pull && reload'
