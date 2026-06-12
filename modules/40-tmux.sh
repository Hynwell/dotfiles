#!/usr/bin/env bash
set -euo pipefail

module_tmux() {
    log_title "tmux"

    apt_install tmux

    symlink "$DOTFILES_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"

    log_ok "tmux done"
}
