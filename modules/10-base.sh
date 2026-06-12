#!/usr/bin/env bash
set -euo pipefail

module_base() {
    log_title "Base packages"

    require_debian
    apt_update_once
    log_info "Upgrading system..."
    sudo apt-get upgrade -y -qq

    apt_install \
        curl \
        git \
        ca-certificates \
        gnupg \
        lsb-release \
        build-essential \
        unzip \
        wget

    log_ok "Base packages done"
}
