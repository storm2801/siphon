#!/usr/bin/env bash
# siphon installer — copies siphon to ~/bin and adds it to PATH.
# Usage: bash install.sh

set -u
SRC="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/bin"
TARGET="$BIN_DIR/siphon"
ZSHRC="$HOME/.zshrc"

C_RESET=$'\033[0m'
C_BOLD=$'\033[1m'
C_BLUE=$'\033[38;5;33m'
C_GREY=$'\033[38;5;245m'
C_GREEN=$'\033[32m'
C_RED=$'\033[31m'

ok()   { printf '  %s✓%s  %s\n' "$C_GREEN" "$C_RESET" "$1"; }
err()  { printf '  %s✗%s  %s\n' "$C_RED" "$C_RESET" "$1"; }
info() { printf '  %s·%s  %s\n' "$C_GREY" "$C_RESET" "$1"; }

printf '\n  %s%ssiphon%s  %s·  installer%s\n\n' \
  "$C_BOLD" "$C_BLUE" "$C_RESET" "$C_GREY" "$C_RESET"

MISSING=0
for p in yt-dlp ffmpeg; do
  if command -v "$p" >/dev/null 2>&1; then ok "$p"
  else err "$p (falta)"; MISSING=1; fi
done

if [ "$MISSING" = "1" ]; then
  if command -v brew >/dev/null 2>&1; then
    printf '\n  ¿Instalar yt-dlp + ffmpeg con Homebrew? [S/n] '
    read -r a
    case "$a" in
      [nN]*) echo "  Instálalos a mano y vuelve a ejecutar este script."; exit 1 ;;
      *) brew install yt-dlp ffmpeg || exit 1 ;;
    esac
  else
    printf '\n  Homebrew no está instalado. Instálalo primero:\n\n'
    printf '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\n\n'
    exit 1
  fi
fi

mkdir -p "$BIN_DIR" || { err "No pude crear $BIN_DIR"; exit 1; }
cp "$SRC/siphon" "$TARGET" || { err "No pude copiar el script"; exit 1; }
chmod +x "$TARGET"
ok "$TARGET"

touch "$ZSHRC"
if grep -q 'HOME/bin' "$ZSHRC"; then
  info "\$HOME/bin ya estaba en ~/.zshrc"
else
  printf '\n# siphon\nexport PATH="$HOME/bin:$PATH"\n' >> "$ZSHRC"
  ok "\$HOME/bin añadido a ~/.zshrc"
fi

printf '\n  %s✓  Listo.%s  Ejecuta:  source ~/.zshrc && siphon\n\n' \
  "$C_GREEN" "$C_RESET"
