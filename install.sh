#!/usr/bin/env bash
# Siphon installer - works on macOS and Linux.
#   Local:  bash install.sh
#   Remote: curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash

# shellcheck disable=SC2016  # we write $HOME literally to the shell rc
set -u

VERSION="2.0.6"
REPO_RAW="https://raw.githubusercontent.com/storm2801/siphon/main/siphon"
BIN_DIR="$HOME/bin"
TARGET="$BIN_DIR/siphon"

case "$(uname -s)" in
    Darwin*) OS="macos" ;;
    Linux*)  OS="linux" ;;
    *)       OS="unknown" ;;
esac

if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

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

info "Detected: $OS"
info "Shell rc: $SHELL_RC"

printf '\n  Checking dependencies...\n'
MISSING=0
for p in yt-dlp ffmpeg; do
    if command -v "$p" >/dev/null 2>&1; then ok "$p"
    else err "$p (not found)"; MISSING=1; fi
done

if [ "$MISSING" = "1" ]; then
    case "$OS" in
        macos)
            if command -v brew >/dev/null 2>&1; then
                printf '\n  Install yt-dlp + ffmpeg via Homebrew? [Y/n] '
                read -r answer
                case "$answer" in
                    [nN]*) printf '  Install manually and re-run.\n'; exit 1 ;;
                    *) brew install yt-dlp ffmpeg || exit 1 ;;
                esac
            else
                printf '\n  Homebrew not found. Install it first:\n\n'
                printf '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\n\n'
                exit 1
            fi
            ;;
        linux)
            if command -v apt >/dev/null 2>&1; then
                printf '\n  Install yt-dlp + ffmpeg via apt? [Y/n] '
                read -r answer
                case "$answer" in
                    [nN]*) exit 1 ;;
                    *) sudo apt update && sudo apt install -y yt-dlp ffmpeg || exit 1 ;;
                esac
            elif command -v dnf >/dev/null 2>&1; then
                printf '\n  Install yt-dlp + ffmpeg via dnf? [Y/n] '
                read -r answer
                case "$answer" in
                    [nN]*) exit 1 ;;
                    *) sudo dnf install -y yt-dlp ffmpeg || exit 1 ;;
                esac
            elif command -v pacman >/dev/null 2>&1; then
                printf '\n  Install yt-dlp + ffmpeg via pacman? [Y/n] '
                read -r answer
                case "$answer" in
                    [nN]*) exit 1 ;;
                    *) sudo pacman -S --noconfirm yt-dlp ffmpeg || exit 1 ;;
                esac
            else
                printf '\n  No supported package manager found.\n'
                printf '  Install yt-dlp and ffmpeg manually and re-run.\n\n'
                exit 1
            fi
            ;;
        *)
            printf '\n  Unsupported OS. Install yt-dlp and ffmpeg manually.\n\n'
            exit 1
            ;;
    esac
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

printf '\n  Configuring PATH in %s...\n' "$SHELL_RC"
touch "$SHELL_RC"
if grep -q 'HOME/bin' "$SHELL_RC"; then
    info "\$HOME/bin already present"
else
    printf '\n# siphon\nexport PATH="$HOME/bin:$PATH"\n' >> "$SHELL_RC"
    ok "\$HOME/bin added to $SHELL_RC"
fi

printf '\n  %sDone.%s\n\n' "$C_GREEN" "$C_RESET"
printf '  Open a new terminal, or run: source %s\n' "$SHELL_RC"
printf '  Then type: siphon\n\n'
