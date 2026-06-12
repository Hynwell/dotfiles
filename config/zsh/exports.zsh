## Exports and environment variables

if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    export EDITOR="vim"
    export VISUAL="vim"
fi

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Directory stack (cd history)
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# PATH: local binaries first
export PATH="$HOME/.local/bin:$PATH"

# fzf options
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --info=inline"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# bat theme
export BAT_THEME="Dracula"

# less
export LESS="-R --use-color"

# Чтобы sudo -s и прочие инструменты использовали zsh
export SHELL="$(command -v zsh)"
