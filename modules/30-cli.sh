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
        btop \
        tldr \

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

    # On Debian/Ubuntu bat binary is called batcat, fd binary is fdfind
    # Create ~/.local/bin wrappers so aliases and scripts can just use bat/fd
    local local_bin="$HOME/.local/bin"
    mkdir -p "$local_bin"

    if has_cmd batcat && [[ ! -x "$local_bin/bat" ]]; then
        ln -sf "$(which batcat)" "$local_bin/bat"
        log_ok "Linked batcat → ~/.local/bin/bat"
    fi

    if has_cmd fdfind && [[ ! -x "$local_bin/fd" ]]; then
        ln -sf "$(which fdfind)" "$local_bin/fd"
        log_ok "Linked fdfind → ~/.local/bin/fd"
    fi

    log_ok "Modern CLI tools done"
}
