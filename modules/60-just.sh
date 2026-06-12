#!/usr/bin/env bash
set -euo pipefail

module_just() {
    log_title "just"

    if ! has_cmd just; then
        log_info "Installing just via official install script..."
        curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh \
            | bash -s -- --to "$HOME/.local/bin"
    else
        log_ok "just already installed"
    fi

    log_ok "just done"
}
