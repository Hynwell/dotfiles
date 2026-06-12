#!/usr/bin/env bash
set -euo pipefail

module_nvim() {
    log_title "Neovim"

    local local_bin="$HOME/.local/bin"
    mkdir -p "$local_bin"

    # Install Neovim from official GitHub release (apt version is too old)
    if ! has_cmd nvim; then
        log_info "Installing Neovim from GitHub releases..."
        local arch
        arch="$(dpkg --print-architecture)"
        local nvim_arch
        case "$arch" in
            amd64) nvim_arch="x86_64" ;;
            arm64) nvim_arch="arm64"  ;;
            *)
                log_err "Unsupported arch for Neovim binary: $arch"
                return 1
                ;;
        esac
        local tmp_dir
        tmp_dir="$(mktemp -d)"
        local tarball="nvim-linux-${nvim_arch}.tar.gz"
        curl -fsSL \
            "https://github.com/neovim/neovim/releases/latest/download/${tarball}" \
            -o "$tmp_dir/${tarball}"
        sudo tar -C /opt -xzf "$tmp_dir/${tarball}"
        sudo ln -sfn "/opt/nvim-linux-${nvim_arch}/bin/nvim" /usr/local/bin/nvim
        rm -rf "$tmp_dir"
        log_ok "Neovim installed: $(nvim --version | head -1)"
    else
        log_ok "Neovim already installed: $(nvim --version | head -1)"
    fi

    # Symlink config
    symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

    # Warm up plugins headless (non-fatal)
    if has_cmd nvim; then
        log_info "Bootstrapping Neovim plugins (headless)..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
        log_ok "Plugins ready"
    fi

    log_ok "Neovim done"
}
