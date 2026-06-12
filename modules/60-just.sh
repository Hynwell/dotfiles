#!/usr/bin/env bash
set -euo pipefail

module_just() {
    log_title "just"

    if ! has_cmd just; then
        log_info "Adding prebuilt-mpr repository for just..."
        curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' \
            | gpg --dearmor \
            | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg > /dev/null
        local codename
        codename="$(lsb_release -cs)"
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] \
https://proget.makedeb.org prebuilt-mpr ${codename}" \
            | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list > /dev/null
        _APT_UPDATED=0
        apt_install just
    else
        log_ok "just already installed"
    fi

    log_ok "just done"
}
