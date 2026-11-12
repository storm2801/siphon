<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:4D6BFE,100:6E8FFF&height=220&section=header&text=Siphon&fontSize=96&fontColor=ffffff&animation=fadeIn&fontAlignY=40&desc=Draw%20the%20media%20you%20want%2C%20clean.&descAlignY=62&descSize=20" alt="Siphon" />

<div align="center">

**Draw the media you want, clean.**

A terminal downloader for macOS. Paste a link, pick what you want, watch it land.

[![Release](https://img.shields.io/github/v/release/storm2801/siphon?style=flat&label=version)](https://github.com/storm2801/siphon/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos/)
[![CI](https://github.com/storm2801/siphon/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/storm2801/siphon/actions/workflows/shellcheck.yml)
[![Stars](https://img.shields.io/github/stars/storm2801/siphon?style=flat)](https://github.com/storm2801/siphon/stargazers)

[Quick start](#quick-start) · [Demo](#demo) · [Advanced usage](#advanced-usage) · [Changelog](CHANGELOG.md)

</div>

---

## Quick start

Pick one. The first is the easiest.

### Option 1 — Double-click (no Terminal)

1. Download **[Siphon.command](https://raw.githubusercontent.com/storm2801/siphon/main/Siphon.command)** to your Downloads folder
2. Right-click → **Open** (macOS asks once, confirm)
3. A Terminal window opens, Siphon installs itself, and you're done

You'll be asked for a URL. Paste it. Follow the prompts. Your file is in `~/Downloads`.

### Option 2 — One-line install

If you're comfortable with Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash
source ~/.zshrc
siphon
```

Installs to `~/bin/siphon`, adds it to your `PATH`, done.

### Option 3 — From source

```
git clone https://github.com/storm2801/siphon.git
cd siphon
bash install.sh
source ~/.zshrc
```

### Requirements

- **macOS** — Ventura, Sonoma, Sequoia, or any recent release
- [**Homebrew**](https://brew.sh/) — the installer uses it for the two dependencies
- `yt-dlp` and `ffmpeg` — the installer handles them

---

## Demo

```
  Siphon  ·  multi-platform downloader  v1.5.0
  ─────────────────────────────────────────────

  Pega la URL del vídeo: [Enter = portapapeles]
    > https://youtu.be/dQw4w9WgXcQ

  /  Obteniendo información…

  ─────────────────────────────────────────────
  Plataforma    YouTube
  Título        Artist — Song Title
  Duración      4m 12s
  Calidades     2160p · 1440p · 1080p · 720p · 480p
  ─────────────────────────────────────────────

  ¿Vídeo o audio?
    1)  Vídeo
    2)  Audio
    > 1

  ¿Descargar ahora? [S/n] s

    ▸ Vídeo  Artist — Song Title [dQw4w9WgXcQ].f401.mp4
      [████████████████████████████████] 100%  ·  12.4 MB/s  ·  ETA 00:00
    ▸ Audio  Artist — Song Title [dQw4w9WgXcQ].f140.m4a
      [████████████████░░░░░░░░░░░░░░░░]  48%  ·  8.42 MB/s  ·  ETA 00:47
    · Combinando pistas…

  ✓  Descarga completada
```

---

## Supported platforms

| Platform | Video | Audio | Notes |
|---|---|---|---|
| YouTube | ✓ | ✓ | Playlists, subtitles, live |
| Instagram | ✓ | ✓ | Reels, posts, stories |
| TikTok | ✓ | ✓ | Watermark-free available |
| Facebook | ✓ | ✓ | Public videos |
| X (Twitter) | ✓ | ✓ | Posts and threads |
| Reddit | ✓ | ✓ | v.redd.it videos |
| Vimeo | ✓ | ✓ | Public videos |
| Twitch | ✓ | ✓ | VODs and clips |
| SoundCloud | — | ✓ | Audio-only platform |
| Dailymotion | ✓ | ✓ | Public videos |

Siphon is a frontend for `yt-dlp`. Anything `yt-dlp` supports, Siphon supports. If it's not in the table, try it anyway — it will probably work.

---

## Why Siphon

Most downloaders are one of three things:

- **Browser extensions** that break every other week, inject ads, or track you.
- **GUI apps** that bundle a whole Electron runtime just to wrap `yt-dlp`.
- **Raw `yt-dlp` commands** — powerful, but you have to remember `-f "bv*[height<=1080]+ba/b"` every time.

Siphon is the fourth option: a thin, readable bash wrapper around `yt-dlp` that guides you through the choices with a clean UI and then gets out of the way.

---

## Features

| ↕▾ | ↕▾ |
|---|---|
| −**Multi-platform** | YouTube, Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud, Dailymotion. |
| **Real quality detection** | Queries the video first and only offers resolutions that actually exist. |
| **Video or audio** | Full video in MP4/MKV, or just the audio as MP3, WAV, or M4A. |
| **Subtitles** | Embed them or save as `.srt` sidecars. Spanish, English, or both. |
| **Playlists** | Paste a playlist URL and download everything with numbered filenames. |
| **Clean progress bar** | One line per stream, fills smoothly. Speed and ETA included. |
| **Clipboard** | Press Enter on an empty URL prompt and it pulls from your clipboard. |
| **Batch mode** | `siphon --batch urls.txt` downloads a whole list. |
| **Env vars** | Set `SIPHON_MODE`, `SIPHON_QUALITY`, etc. to skip prompts. |
| **Config file** | `~/.siphonrc` remembers your preferences. |
| **CI validated** | Every push runs ShellCheck via GitHub Actions. |
⚙

---

## Advanced usage

Optional. Skip this if you just want to download something.

### Flags

| Flag ↕▾ | Description ↕▾ |
|---|---|
| −`--help`, `-h` | Show usage |
| `--version`, `-v` | Show version |
| `--batch FILE` | Download every URL in FILE (one per line) |
| `--init` | Create a sample `~/.siphonrc` |
| `--show-config` | Show the effective configuration |
⚙

### Batch mode

Download every URL in a text file. One per line. Blank lines and lines starting with `#` are ignored.

```
siphon --batch urls.txt
```

Siphon asks format once and applies it to every URL. At the end, you get a summary with any failed URLs listed.

### Configuration file

Persist your preferences in `~/.siphonrc`:

```
siphon --init
```

Then uncomment and edit what you want:

```
# ~/.siphonrc
dest=~/Downloads
mode=1          # 1=video, 2=audio
quality=1080    # best | 1080 | 720 | 480
container=1     # 1=mp4, 2=mkv
subs=1          # 1=none, 2=es embed, 3=es .srt, ... 7
audio_format=2  # 1=mp3, 2=wav, 3=m4a
```

Inspect current config with `siphon --show-config`.

**Precedence:** env var > `~/.siphonrc` > runtime prompt.

### Environment variables

Skip any prompt:

```
SIPHON_MODE=2 SIPHON_AUDIO=1 siphon
```

| Variable ↕▾ | Values ↕▾ |
|---|---|
| −`SIPHON_DEST` | Any writable path |
| `SIPHON_MODE` | `1` video, `2` audio |
| `SIPHON_QUALITY` | `best`, `1080`, `720`, `480` |
| `SIPHON_CONTAINER` | `1` mp4, `2` mkv |
| `SIPHON_SUBS` | `1`–`7` |
| `SIPHON_AUDIO` | `1` mp3, `2` wav, `3` m4a |
⚙

### Change the download folder

Default: `$HOME/Downloads`. Override with `SIPHON_DEST`:

```
SIPHON_DEST=~/Videos siphon
```

To make it permanent, add to `~/.zshrc`:

```
export SIPHON_DEST="$HOME/Videos"
```

---

## How it works

Siphon is a thin bash wrapper around `yt-dlp`. It handles three things:

1. **Asks questions** in a friendly way — menus, colored output, confirmations.
2. **Translates your answers** into `yt-dlp` flags — `-f "bv*[height<=1080]+ba/b"`, `--audio-format mp3`, `--embed-subs`, etc.
3. **Formats the output** — a clean progress bar instead of raw `yt-dlp` logging.

No dependencies beyond what `yt-dlp` already needs. No Python venv, no Node, no package manager beyond Homebrew.

### Technologies

| Layer ↕▾ | Tool ↕▾ | Role ↕▾ |
|---|---|---|
| −Download engine | [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) | Extracts metadata, downloads streams |
| Media processing | [`ffmpeg`](https://ffmpeg.org/) | Merges streams, converts audio, embeds subtitles |
| Metadata parsing | `python3` (stdlib only) | Parses `yt-dlp -J` JSON output |
| UI / logic | `bash` 3.2+ | Menus, progress bar, control flow |
⚙

---

## Troubleshooting

| Symptom ↕▾ | Fix ↕▾ |
|---|---|
| −`Sign in to confirm you're not a bot` | `yt-dlp --cookies-from-browser safari "URL"` (or `chrome`, `firefox`) |
| "Format not available" or only 720p | `brew upgrade yt-dlp` |
| Download stalls mid-way | Re-run `siphon`: `--continue` resumes |
| `siphon: command not found` | `source ~/.zshrc` or open a fresh terminal |
| Video imports to DaVinci with no audio | Choose **WAV** in the audio menu |
| macOS blocks the script | System Settings → Privacy & Security → **Allow anyway** |
⚙

For anything else, open an [issue](https://github.com/storm2801/siphon/issues) with the full `yt-dlp` output.

---

## Roadmap

- ☑  
**v1.0** — YouTube support, quality detection, subtitle control
- ☑  
**v1.1** — Multi-platform: Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud
- ☑  
**v1.2** — Clipboard fallback, ETA and speed in progress bar
- ☑  
**v1.3** — Batch mode: `siphon --batch urls.txt`
- ☑  
**v1.4** — Env vars, config file, ShellCheck CI
- ☑  
**v1.5** — Double-click launcher, one-line installer, community files
- □  
**v2.0** — Linux support

See CHANGELOG.md for details.

---

## FAQ

**Is this legal?**
Siphon is a tool, not a service. Download only content you own, content under a free license, or content you have explicit permission to download. See Legal.

**Why does it ask so many questions?**
Because quality, format, and subtitles depend entirely on the video and what you plan to do with it. Siphon gets you exactly the file you want, not a 4K WebM you'll spend five minutes converting.

**Can I script it?**
Yes. Use `siphon --batch` for lists, env vars for one-off defaults, or `~/.siphonrc` for persistence.

**Does it work on Linux?**
Not officially tested, but the code is portable bash and only depends on `yt-dlp` + `ffmpeg`. It will probably work. PRs welcome.

**Why is the UI in Spanish?**
It's the author's language. A `SIPHON_LANG` environment variable is a reasonable v2 feature.

---

## Contributing

Issues and pull requests are welcome. See CONTRIBUTING.md for guidelines.

---

## Legal

Download only content you own, content under a free license, or content you have explicit permission to download. Downloading copyrighted material without authorization violates the platforms' Terms of Service.

This project is a tool, not a service. What you do with it is your responsibility.

---

## Author

Built by **[storm2801](https://github.com/storm2801)** in 2026.

Siphon is MIT-licensed. The original copyright notice and this attribution must remain in any fork or redistribution. See AUTHORS.md and LICENSE.

If you find this useful, [give it a star](https://github.com/storm2801/siphon/stargazers) — it helps others find it.

---

## License

[MIT](LICENSE) © 2026 storm2801

---

## Credits

- Built on top of [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) and [`ffmpeg`](https://ffmpeg.org/).
- Terminal UI inspired by the simplicity of `git`, `tig`, and `lazygit`.
- Progress bar and menu patterns inspired by Unix tools that get out of the way.

</BDS:create_file>
<BDS:create_file fileName="install.sh">

```bash
#!/usr/bin/env bash
# Siphon installer — works both from a local clone and via curl | bash.
#
#   From local clone:   bash install.sh
#   From internet:      curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash

set -u

VERSION="1.5.0"
REPO_RAW="https://raw.githubusercontent.com/storm2801/siphon/main/siphon"
BIN_DIR="$HOME/bin"
TARGET="$BIN_DIR/siphon"
ZSHRC="$HOME/.zshrc"

# Detect local source
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
fi
LOCAL_SIPHON=""
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/siphon" ]; then
    LOCAL_SIPHON="$SCRIPT_DIR/siphon"
fi

# Colors
C_RESET=$'\033[0m'
C_BOLD=$'\033[1m'
C_BLUE=$'\033[38;5;33m'
C_GREY=$'\033[38;5;245m'
C_GREEN=$'\033[32m'
C_RED=$'\033[31m'

ok()   { printf '  %s✓%s  %s\n' "$C_GREEN" "$C_RESET" "$1"; }
err()  { printf '  %s✗%s  %s\n' "$C_RED" "$C_RESET" "$1"; }
info() { printf '  %s·%s  %s\n' "$C_GREY" "$C_RESET" "$1"; }

printf '\n  %s%ssiphon%s  %s·  installer v%s%s\n\n' \
    "$C_BOLD" "$C_BLUE" "$C_RESET" "$C_GREY" "$VERSION" "$C_RESET"

# 1. Dependencies
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
            [nN]*) printf '  Install them manually and re-run this installer.\n'; exit 1 ;;
            *) brew install yt-dlp ffmpeg || exit 1 ;;
        esac
    else
        printf '\n  Homebrew not found. Install it first:\n\n'
        printf '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\n\n'
        exit 1
    fi
fi

# 2. Install siphon
printf '\n  Installing siphon...\n'
mkdir -p "$BIN_DIR" || { err "Cannot create $BIN_DIR"; exit 1; }

if [ -n "$LOCAL_SIPHON" ]; then
    cp "$LOCAL_SIPHON" "$TARGET" || { err "Cannot copy siphon"; exit 1; }
    info "from local source"
else
    if ! command -v curl >/dev/null 2>&1; then
        err "curl not found and no local siphon to copy"
        exit 1
    fi
    curl -fsSL "$REPO_RAW" -o "$TARGET" || { err "Download failed"; exit 1; }
    info "downloaded from GitHub"
fi
chmod +x "$TARGET"
ok "$TARGET"

# 3. PATH
printf '\n  Configuring PATH...\n'
touch "$ZSHRC"
if grep -q 'HOME/bin' "$ZSHRC"; then
    info "\$HOME/bin already in ~/.zshrc"
else
    printf '\n# siphon\nexport PATH="$HOME/bin:$PATH"\n' >> "$ZSHRC"
    ok "\$HOME/bin added to ~/.zshrc"
fi

# Done
printf '\n  %s✓  Done.%s\n\n' "$C_GREEN" "$C_RESET"
printf '  Open a new terminal (or run: %ssource ~/.zshrc%s)\n' "$C_BOLD" "$C_RESET"
printf '  Then type:\n\n'
printf '    %ssiphon%s\n\n' "$C_BOLD" "$C_RESET"

