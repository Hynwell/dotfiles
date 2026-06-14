#!/usr/bin/env bash
set -euo pipefail

module_cli() {
    log_title "Modern CLI tools"

    # eza (modern ls) — requires its own repo on older Ubuntu/Debian
    if ! has_cmd eza; then
        log_info "Adding eza repository..."
        add_repo_key "eza" "https://raw.githubusercontent.com/eza-community/eza/main/deb.asc"
        local codename
        codename="$(lsb_release -cs)"
        add_repo_source "eza" \
            "deb [signed-by=/etc/apt/keyrings/eza.gpg] https://deb.gierens.de stable main"
        _APT_UPDATED=0
        apt_install eza
    else
        log_ok "eza already installed"
    fi

    # Standard apt packages
    apt_install \
        bat \
        fd-find \
        ripgrep \
        zoxide \
        btop

    # tldr — tealdeer binary (tldr not in apt on all distros)
    if ! has_cmd tldr; then
        log_info "Installing tealdeer (tldr)..."
        local arch
        arch="$(dpkg --print-architecture)"
        local tl_arch
        case "$arch" in
            amd64)  tl_arch="x86_64-musl" ;;
            arm64)  tl_arch="aarch64-musl" ;;
            armhf)  tl_arch="arm-musleabihf" ;;
            *)      log_warn "Unsupported arch for tealdeer: $arch"; tl_arch="" ;;
        esac
        if [[ -n "$tl_arch" ]]; then
            curl -fsSL "https://github.com/dbrgn/tealdeer/releases/latest/download/tealdeer-linux-${tl_arch}" \
                -o /tmp/tldr
            sudo install -m 0755 /tmp/tldr /usr/local/bin/tldr
            rm -f /tmp/tldr
            log_ok "tealdeer installed → /usr/local/bin/tldr"
        fi
    else
        log_ok "tldr already installed"
    fi

    # delta (git-delta) — not always in apt, install from GitHub releases
    if ! has_cmd delta; then
        log_info "Installing git-delta..."
        local arch
        arch="$(dpkg --print-architecture)"
        local delta_ver="0.17.0"
        local deb_name="git-delta_${delta_ver}_${arch}.deb"
        local tmp="/tmp/${deb_name}"
        curl -fsSL "https://github.com/dandavison/delta/releases/download/${delta_ver}/${deb_name}" -o "$tmp"
        sudo dpkg -i "$tmp"
        rm -f "$tmp"
    else
        log_ok "delta already installed"
    fi

    # On Debian/Ubuntu bat binary is called batcat, fd binary is fdfind.
    # Create system-wide wrappers in /usr/local/bin so aliases work for BOTH
    # the user and root (root's PATH does not include the user's ~/.local/bin).
    if has_cmd batcat && [[ "$(readlink -f /usr/local/bin/bat 2>/dev/null)" != "$(command -v batcat)" ]]; then
        sudo ln -sfn "$(command -v batcat)" /usr/local/bin/bat
        log_ok "Linked batcat → /usr/local/bin/bat"
    fi

    if has_cmd fdfind && [[ "$(readlink -f /usr/local/bin/fd 2>/dev/null)" != "$(command -v fdfind)" ]]; then
        sudo ln -sfn "$(command -v fdfind)" /usr/local/bin/fd
        log_ok "Linked fdfind → /usr/local/bin/fd"
    fi

    log_ok "Modern CLI tools done"
}
