#!/usr/bin/env bash
set -euo pipefail

# Bootstrap: download from the network and run on a fresh machine.
# Usage:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Hynwell/<repo>/main/bootstrap.sh)"
#   bash -c "$(curl -fsSL ...bootstrap.sh)" -- --with-docker

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/Hynwell/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# --- helpers ---
_bold='\033[1m'
_green='\033[0;32m'
_cyan='\033[0;36m'
_red='\033[0;31m'
_nc='\033[0m'

info()  { printf "${_cyan}  → %s${_nc}\n" "$*"; }
ok()    { printf "${_green}  ✓ %s${_nc}\n" "$*"; }
err()   { printf "${_red}  ✗ %s${_nc}\n" "$*" >&2; exit 1; }

# --- require Debian/Ubuntu ---
if ! command -v apt-get &>/dev/null; then
    err "This setup requires Debian/Ubuntu (apt-get not found)"
fi

printf "\n${_bold}${_cyan}dotfiles bootstrap${_nc}\n\n"

# --- install git and curl if missing ---
if ! command -v git &>/dev/null || ! command -v curl &>/dev/null; then
    info "Installing git and curl..."
    sudo apt-get update -qq
    sudo apt-get install -y git curl
fi

# --- clone or update dotfiles repo ---
if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "Updating existing dotfiles at $DOTFILES_DIR..."
    git -C "$DOTFILES_DIR" pull --rebase --autostash
    ok "Updated"
else
    info "Cloning dotfiles to $DOTFILES_DIR..."
    git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    ok "Cloned"
fi

# --- run install.sh with any forwarded flags ---
chmod +x "$DOTFILES_DIR/install.sh"
export DOTFILES_DIR
exec "$DOTFILES_DIR/install.sh" "$@"
