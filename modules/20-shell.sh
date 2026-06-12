#!/usr/bin/env bash
set -euo pipefail

module_shell() {
    log_title "Shell: zsh + Starship + plugins"

    # zsh
    apt_install zsh

    # Starship prompt
    if ! has_cmd starship; then
        log_info "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes
    else
        log_ok "Starship already installed"
    fi

    # zsh plugins
    local plugins_dir="$HOME/.local/share/zsh/plugins"
    mkdir -p "$plugins_dir"

    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        log_info "Cloning zsh-autosuggestions..."
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
            "$plugins_dir/zsh-autosuggestions"
    else
        log_ok "zsh-autosuggestions already present"
    fi

    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        log_info "Cloning zsh-syntax-highlighting..."
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$plugins_dir/zsh-syntax-highlighting"
    else
        log_ok "zsh-syntax-highlighting already present"
    fi

    # fzf (shell integration)
    if ! has_cmd fzf; then
        log_info "Installing fzf..."
        if [[ ! -d "$HOME/.fzf" ]]; then
            git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        else
            log_info "~/.fzf dir exists, updating..."
            git -C "$HOME/.fzf" pull --rebase
        fi
        "$HOME/.fzf/install" --key-bindings --completion --no-update-rc
    else
        log_ok "fzf already installed"
    fi

    # Symlink zsh configs
    local zsh_config_dir="$DOTFILES_DIR/config/zsh"
    symlink "$zsh_config_dir/zshrc"  "$HOME/.zshrc"
    mkdir -p "$HOME/.config/zsh"
    symlink "$zsh_config_dir/aliases.zsh"   "$HOME/.config/zsh/aliases.zsh"
    symlink "$zsh_config_dir/exports.zsh"   "$HOME/.config/zsh/exports.zsh"
    symlink "$zsh_config_dir/functions.zsh" "$HOME/.config/zsh/functions.zsh"
    symlink "$zsh_config_dir/plugins.zsh"   "$HOME/.config/zsh/plugins.zsh"
    symlink "$zsh_config_dir/cheat.zsh"     "$HOME/.config/zsh/cheat.zsh"

    # Starship config
    mkdir -p "$HOME/.config/starship"
    symlink "$DOTFILES_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"

    # Change default shell
    if [[ "$NO_CHSH" -eq 0 ]]; then
        local zsh_path
        zsh_path="$(which zsh)"
        if [[ "$SHELL" != "$zsh_path" ]]; then
            log_info "Changing default shell to zsh..."
            sudo usermod -s "$zsh_path" "$USER"
        else
            log_ok "Default shell is already zsh"
        fi
        # Also set zsh for root so sudo -s gets the same shell
        if [[ "$(getent passwd root | cut -d: -f7)" != "$zsh_path" ]]; then
            log_info "Setting zsh as root shell..."
            sudo usermod -s "$zsh_path" root
        fi
    fi

    # Create /root/.zshrc that sources user's config (for sudo -s)
    if [[ ! -f /root/.zshrc ]]; then
        log_info "Creating /root/.zshrc → sources user config..."
        sudo tee /root/.zshrc > /dev/null <<EOF
# Source dotfiles from $USER for sudo -s sessions
export DOTFILES_DIR="$DOTFILES_DIR"
export XDG_CONFIG_HOME="$HOME/.config"
[[ -f "$HOME/.zshrc" ]] && source "$HOME/.zshrc"
EOF
        log_ok "Created /root/.zshrc"
    else
        log_ok "/root/.zshrc already exists"
    fi

    log_ok "Shell setup done"
}
