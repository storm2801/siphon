#!/usr/bin/env bash
# Siphon - double-click launcher for macOS
# Download this file, right-click -> Open (first time only), follow prompts.
set -u

if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
    cd "$SCRIPT_DIR" 2>/dev/null
else
    SCRIPT_DIR=""
fi

clear 2>/dev/null || true

printf '\n'
printf '   ============================================\n'
printf '    S I P H O N\n'
printf '    Draw the media you want, clean.\n'
printf '   ============================================\n'
printf '\n'

if [ ! -x "$HOME/bin/siphon" ]; then
    printf '   First time here. Installing Siphon...\n\n'
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/install.sh" ]; then
        bash "$SCRIPT_DIR/install.sh"
    else
        curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash
    fi
    printf '\n   Press Enter to continue...'
    read -r _
    clear 2>/dev/null || true
fi

export PATH="$HOME/bin:$PATH"
siphon

printf '\n   Press Enter to close this window...'
read -r _
