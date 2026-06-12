#!/usr/bin/env bash
set -euo pipefail

module_nvim() {
    log_title "Neovim"

    # Pinned to a stable 0.11.x — compatible with nvim-treesitter `master` branch.
    # (treesitter `master` supports Nvim 0.11 only; `main` needs 0.12+.)
    local NVIM_VERSION="v0.11.7"
    local clean="${NVIM_CLEAN:-0}"   # NVIM_CLEAN=1 forces a clean state rebuild

    # Currently installed version (if any)
    local installed=""
    has_cmd nvim && installed="$(nvim --version | head -1 | awk '{print $2}')"

    if [[ "$installed" != "$NVIM_VERSION" ]]; then
        log_info "Installing Neovim ${NVIM_VERSION} (was: ${installed:-none})..."
        local arch nvim_arch
        arch="$(dpkg --print-architecture)"
        case "$arch" in
            amd64) nvim_arch="x86_64" ;;
            arm64) nvim_arch="arm64"  ;;
            *)
                log_err "Unsupported arch for Neovim binary: $arch"
                return 1
                ;;
        esac
        local tarball="nvim-linux-${nvim_arch}.tar.gz"
        local tmp_dir
        tmp_dir="$(mktemp -d)"
        curl -fsSL \
            "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}" \
            -o "$tmp_dir/${tarball}"
        sudo rm -rf "/opt/nvim-linux-${nvim_arch}"
        sudo tar -C /opt -xzf "$tmp_dir/${tarball}"
        sudo ln -sfn "/opt/nvim-linux-${nvim_arch}/bin/nvim" /usr/local/bin/nvim
        rm -rf "$tmp_dir"
        clean=1   # version changed → wipe stale plugins/parsers
        log_ok "Neovim installed: $(nvim --version | head -1)"
    else
        log_ok "Neovim already ${NVIM_VERSION}"
    fi

    # Wipe generated state (plugins + compiled parsers) — but NOT ~/.config/nvim (repo symlink)
    if [[ "$clean" == "1" ]]; then
        log_info "Wiping stale Neovim state (plugins + parsers)..."
        rm -rf "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"
    fi

    # Symlink config from repo
    symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

    # Warm up plugins headless (non-fatal)
    if has_cmd nvim; then
        log_info "Bootstrapping Neovim plugins (headless)..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
        nvim --headless "+TSUpdate"    +qa 2>/dev/null || true
        log_ok "Plugins ready"
    fi

    log_ok "Neovim done"
}
