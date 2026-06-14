## Система, навигация, редактор, shell — алиасы + функции

## Навигация (zoxide)
alias cd='z'
alias cdi='zi'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Система
alias top='btop'
alias md='mkdir -p'

## Just
alias j='just'

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

# показать PATH построчно
path() {
    echo "$PATH" | tr ':' '\n'
}
