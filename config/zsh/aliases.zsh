## Aliases

# ls → eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lta='eza --tree --level=2 --icons -a'

# cat → bat
alias cat='bat --paging=never'

# grep → ripgrep
alias grep='rg'

# cd → zoxide (z)
alias cd='z'
alias cdi='zi'  # interactive selection

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias g='git'

# just — bare, для проектных justfile
alias j='just'

# docker compose
alias dc='docker compose'
alias dup='docker compose up -d'
alias ddown='docker compose down'
alias dre='docker compose up -d --force-recreate'
alias dupd='docker compose pull && docker compose up -d'
alias dps='docker compose ps'
# dlogs — функция в functions.zsh (принимает аргумент tail)

# System
alias top='btop'
alias md='mkdir -p'

# Shell
alias reload='exec zsh'
alias please='sudo $(fc -ln -1)'

# dotfiles quick edit
alias dotfiles='cd "${DOTFILES_DIR:-$HOME/.dotfiles}"'
alias dotfiles-reload='dotfiles && git pull && reload'
