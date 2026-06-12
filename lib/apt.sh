#!/usr/bin/env bash
# apt helpers — source after common.sh

_APT_UPDATED=0

apt_update_once() {
    if [[ "$_APT_UPDATED" -eq 0 ]]; then
        log_info "apt update..."
        sudo apt-get update -qq
        _APT_UPDATED=1
    fi
}

# Install packages only if not already present
# Usage: apt_install pkg1 pkg2 ...
apt_install() {
    local to_install=()
    for pkg in "$@"; do
        if ! dpkg -l "$pkg" &>/dev/null | grep -q '^ii'; then
            to_install+=("$pkg")
        else
            log_ok "Already installed: $pkg"
        fi
    done

    if [[ "${#to_install[@]}" -gt 0 ]]; then
        apt_update_once
        log_info "Installing: ${to_install[*]}"
        sudo apt-get install -y "${to_install[@]}"
    fi
}

# Add an apt repo key from URL, save to /etc/apt/keyrings/<name>.gpg
# Usage: add_repo_key <name> <url>
add_repo_key() {
    local name="$1"
    local url="$2"
    local keyfile="/etc/apt/keyrings/${name}.gpg"
    sudo mkdir -p /etc/apt/keyrings
    if [[ ! -f "$keyfile" ]]; then
        log_info "Adding GPG key: $name"
        curl -fsSL "$url" | sudo gpg --dearmor -o "$keyfile"
        sudo chmod a+r "$keyfile"
    else
        log_ok "GPG key already present: $name"
    fi
}

# Add an apt sources list entry
# Usage: add_repo_source <name> <line>
add_repo_source() {
    local name="$1"
    local line="$2"
    local listfile="/etc/apt/sources.list.d/${name}.list"
    if [[ ! -f "$listfile" ]]; then
        log_info "Adding apt repo: $name"
        echo "$line" | sudo tee "$listfile" > /dev/null
        _APT_UPDATED=0  # force re-update on next apt_install
    else
        log_ok "Apt repo already present: $name"
    fi
}
