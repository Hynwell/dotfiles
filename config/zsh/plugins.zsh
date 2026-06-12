## Shell plugins and tool integrations

ZSH_PLUGINS="$HOME/.local/share/zsh/plugins"

# zsh-autosuggestions
[[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting — must be last
[[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
    source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fzf key bindings and completion
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# zoxide (smart cd)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd z)"
fi

# Starship prompt — must be last
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
