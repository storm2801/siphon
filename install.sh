#!/usr/bin/env bash
# Siphon installer - works both from local clone and via curl | bash.
#   Local: bash install.sh
#   Remote: curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash

set -u
VERSION="1.5.0"
REPO_RAW="https://raw.githubusercontent.com/storm2801/siphon/main/siphon"
BIN_DIR="$HOME/bin"
TARGET="$BIN_DIR/siphon"
ZSHRC="$HOME/.zshrc"

SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
fi
LOCAL_SIPHON=""
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/siphon" ]; then
    LOCAL_SIPHON="$SCRIPT_DIR/siphon"
fi

C_RESET=$'\033[0m'
C_BOLD=$'\033[1m'
C_BLUE=$'\033[38;5;33m'
C_GREY=$'\033[38;5;245m'
C_GREEN=$'\033[32m'
C_RED=$'\033[31m'

ok()   { printf '  %s[OK]%s   %s\n' "$C_GREEN" "$C_RESET" "$1"; }
err()  { printf '  %s[ERR]%s  %s\n' "$C_RED" "$C_RESET" "$1"; }
info() { printf '  %s - %s  %s\n' "$C_GREY" "$C_RESET" "$1"; }

printf '\n  %s%ssiphon%s  %s- installer v%s%s\n\n' \
    "$C_BOLD" "$C_BLUE" "$C_RESET" "$C_GREY" "$VERSION" "$C_RESET"

printf '  Checking dependencies...\n'
MISSING=0
for p in yt-dlp ffmpeg; do
    if command -v "$p" >/dev/null 2>&1; then ok "$p"
    else err "$p (not found)"; MISSING=1; fi
done

if [ "$MISSING" = "1" ]; then
    if command -v brew >/dev/null 2>&1; then
        printf '\n  Install yt-dlp + ffmpeg via Homebrew? [Y/n] '
        read -r answer
        case "$answer" in
            [nN]*) printf '  Install them manually and re-run.\n'; exit 1 ;;
            *) brew install yt-dlp ffmpeg || exit 1 ;;
        esac
    else
        printf '\n  Homebrew not found. Install it first:\n\n'
        printf '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\n\n'
        exit 1
    fi
fi

printf '\n  Installing siphon...\n'
mkdir -p "$BIN_DIR" || { err "Cannot create $BIN_DIR"; exit 1; }

if [ -n "$LOCAL_SIPHON" ]; then
    cp "$LOCAL_SIPHON" "$TARGET" || { err "Cannot copy siphon"; exit 1; }
    info "from local source"
else
    if ! command -v curl >/dev/null 2>&1; then
        err "curl not found and no local siphon"
        exit 1
    fi
    curl -fsSL "$REPO_RAW" -o "$TARGET" || { err "Download failed"; exit 1; }
    info "downloaded from GitHub"
fi
chmod +x "$TARGET"
ok "$TARGET"

printf '\n  Configuring PATH...\n'
touch "$ZSHRC"
if grep -q 'HOME/bin' "$ZSHRC"; then
    info "\$HOME/bin already in ~/.zshrc"
else
    printf '\n# siphon\nexport PATH="$HOME/bin:$PATH"\n' >> "$ZSHRC"
    ok "\$HOME/bin added to ~/.zshrc"
fi

printf '\n  %sDone.%s\n\n' "$C_GREEN" "$C_RESET"
printf '  Open a new terminal, or run: source ~/.zshrc\n'
printf '  Then type: siphon\n\n'
