#!/usr/bin/env bash
# Common helpers for all modules

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log_info()  { printf "${BLUE}  →${NC} %s\n" "$*"; }
log_ok()    { printf "${GREEN}  ✓${NC} %s\n" "$*"; }
log_warn()  { printf "${YELLOW}  ⚠${NC} %s\n" "$*"; }
log_err()   { printf "${RED}  ✗${NC} %s\n" "$*" >&2; }
log_title() { printf "\n${BOLD}${CYAN}▶ %s${NC}\n" "$*"; }

has_cmd() {
    command -v "$1" &>/dev/null
}

require_debian() {
    if ! has_cmd apt-get; then
        log_err "This setup requires Debian/Ubuntu (apt-get not found)"
        exit 1
    fi
}

# Backup a real file (not symlink) before overwriting
backup_if_real() {
    local dest="$1"
    if [[ -f "$dest" && ! -L "$dest" ]]; then
        local bak="${dest}.bak"
        log_warn "Backing up existing $dest → $bak"
        mv "$dest" "$bak"
    fi
}

# Create symlink with backup of existing real files
# Usage: symlink <source_abs_path> <dest_abs_path>
symlink() {
    local src="$1"
    local dest="$2"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    if [[ ! -e "$src" ]]; then
        log_err "symlink source not found: $src"
        return 1
    fi

    mkdir -p "$dest_dir"
    backup_if_real "$dest"

    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        log_ok "Already linked: $dest"
        return 0
    fi

    ln -sfn "$src" "$dest"
    log_ok "Linked: $dest → $src"
}

# DOTFILES_DIR: where the repo lives (set by install.sh or bootstrap.sh)
: "${DOTFILES_DIR:=$HOME/.dotfiles}"

# NO_CHSH: set to 1 to skip chsh
: "${NO_CHSH:=0}"
