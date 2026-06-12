## Shell plugins and tool integrations

# Переопределяемо — /root/.zshrc указывает на каталоги установившего пользователя
: "${ZSH_PLUGINS:=$HOME/.local/share/zsh/plugins}"

# zsh-autosuggestions
[[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting — must be last
[[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
    source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fzf key bindings and completion
: "${FZF_RC:=$HOME/.fzf.zsh}"
[[ -f "$FZF_RC" ]] && source "$FZF_RC"

# zoxide (smart cd)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd z)"
fi

# Starship prompt — must be last
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
