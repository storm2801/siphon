<div align="center">

# Siphon

**Draw the media you want, clean.**

A minimal terminal downloader for macOS. Paste a link, pick what you want, watch it land.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos/)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/storm2801/siphon/releases)
[![Made with Bash](https://img.shields.io/badge/made%20with-bash-1f425f.svg)](https://www.gnu.org/software/bash/)

[Install](#install) · [Usage](#usage) · [Features](#features) · [Troubleshooting](#troubleshooting) · [Changelog](CHANGELOG.md)

</div>

---

## Demo

```

Siphon  ·  multi-platform downloader  v1.1.0
─────────────────────────────────────────────

Pega la URL del vídeo:

> https://youtu.be/dQw4w9WgXcQ

/  Obteniendo información…

─────────────────────────────────────────────
Plataforma    YouTube
Título        Artist — Song Title
Duración      4m 12s
Calidades     2160p · 1440p · 1080p · 720p · 480p
─────────────────────────────────────────────

¿Vídeo o audio?

1. Vídeo
2. Audio

> 1

¿Descargar ahora? [S/n] s

▸ Vídeo  Artist — Song Title [dQw4w9WgXcQ].f401.mp4
[████████████████████████████████] 100%
▸ Audio  Artist — Song Title [dQw4w9WgXcQ].f140.m4a
[████████████████░░░░░░░░░░░░░░░░]  48%
· Combinando pistas…

✓  Descarga completada

```

---

## Why Siphon?

Most downloaders are one of three things:

1. **Browser extensions** — break every other week, inject ads, or track you.
2. **GUI apps** — bundle a whole Electron runtime just to wrap `yt-dlp`.
3. **Raw `yt-dlp` commands** — powerful, but you have to remember `-f "bv*[height<=1080]+ba/b"` every time.

Siphon is the fourth option: a **thin, readable bash wrapper** around `yt-dlp` that guides you through the choices with a clean UI and then gets out of the way.

---

## Features

| | |
|---|---|
| **Multi-platform** | YouTube, Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud — anything `yt-dlp` supports. |
| **Real quality detection** | Queries the video first and only offers resolutions that actually exist. No "format not available" surprises. |
| **Video or audio** | Full video in MP4/MKV, or just the audio as MP3, WAV, or M4A. |
| **Subtitles** | Embed them or save as `.srt` sidecars. Spanish, English, or both. |
| **Playlists** | Paste a playlist URL and download everything with numbered filenames. |
| **Clean progress bar** | One line per stream, fills smoothly. Not a wall of `[download] 5.3% of ...` noise. |
| **Ctrl+C cancels** | At any step. Kills `yt-dlp`, cleans temp files, exits cleanly. |
| **DaVinci-friendly audio** | WAV 48 kHz stereo, ready for a timeline with zero conversion. |
| **Zero config** | One command, interactive menus, no flags to remember. |

---

## Install

### Requirements

- **macOS** — Ventura, Sonoma, Sequoia, or any recent release
- [**Homebrew**](https://brew.sh)
- `yt-dlp` and `ffmpeg`

```bash
brew install yt-dlp ffmpeg
```

### Quick install

```
git clone https://github.com/storm2801/siphon.git
cd siphon
bash install.sh
source ~/.zshrc
```

The installer:

1. Checks for `yt-dlp` and `ffmpeg`, offers to install them via Homebrew if missing.
2. Copies `siphon` to `~/bin/siphon` and marks it executable.
3. Adds `~/bin` to your `PATH` in `~/.zshrc`. Safe to run twice.

### Manual install

If you'd rather not run a script:

```
mkdir -p ~/bin
cp siphon ~/bin/siphon
chmod +x ~/bin/siphon
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Verify

```
siphon --version
# → siphon 1.1.0
```

---

## Usage

```
siphon
```

Follow the prompts. When in doubt, press **Enter**.

### Flags

| Flag ↕▾ | Description ↕▾ |
|---|---|
| −`--help`, `-h` | Show usage |
| −`--version`, `-v` | Show version |
⚙

### Change the download folder

Default: `$HOME/Downloads`. Override with `SIPHON_DEST`:

```
SIPHON_DEST=~/Videos siphon
```

To make it permanent:

```
echo 'export SIPHON_DEST="$HOME/Videos"' >> ~/.zshrc
source ~/.zshrc
```

---

## Supported platforms

| Platform | Video | Audio | Notes |
|---|---|---|---|
| YouTube | ✅ | ✅ | Playlists, subtitles, live |
| Instagram | ✅ | ✅ | Reels, posts, stories |
| TikTok | ✅ | ✅ | Watermark-free available |
| Facebook | ✅ | ✅ | Public videos |
| X (Twitter) | ✅ | ✅ | Posts and threads |
| Reddit | ✅ | ✅ | v.redd.it videos |
| Vimeo | ✅ | ✅ | Public videos |
| Twitch | ✅ | ✅ | VODs and clips |
| SoundCloud | — | ✅ | Audio-only platform |
| Dailymotion | ✅ | ✅ | Public videos |

Siphon is a frontend for `yt-dlp`. Anything `yt-dlp` supports, Siphon supports. If it's not in the table, try it anyway — it will probably work.

---

## How it works

Siphon is a **thin bash wrapper** around `yt-dlp`. It handles three things:

1. **Asks questions** in a friendly way — menus, colored output, confirmations.
2. **Translates your answers** into `yt-dlp` flags — `-f "bv*[height<=1080]+ba/b"`, `--audio-format mp3`, `--embed-subs`, etc.
3. **Formats the output** — a clean progress bar instead of raw `yt-dlp` logging.

No dependencies beyond what `yt-dlp` already needs. No Python venv, no Node, no package manager beyond Homebrew.

---

## Technologies

| Layer | Tool | Role |
|---|---|---|
| Download engine | [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) | Extracts metadata, downloads streams |
| Media processing | [`ffmpeg`](https://ffmpeg.org/) | Merges streams, converts audio, embeds subtitles |
| Metadata parsing | `python3` (stdlib only) | Parses `yt-dlp -J` JSON output |
| UI / logic | `bash` 3.2+ | Menus, progress bar, control flow |

No `node_modules`. No `pip install`. Just the tools that ship with macOS.

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
- □  
**v1.2** — Batch mode: read URLs from a file
- □  
**v1.3** — Config file (`~/.siphonrc`) to remember preferences
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
Not yet — interactive menus are the whole point. Batch mode and non-interactive flags are on the roadmap.

**Does it work on Linux?**
Not officially tested, but the code is portable bash and only depends on `yt-dlp` + `ffmpeg`. It will probably work. PRs welcome.

**Why is the UI in Spanish?**
It's the author's language. Internationalization is not planned for v1, but a `SIPHON_LANG` environment variable is a reasonable v2 feature.

---

## Contributing

Issues and pull requests are welcome.

1. Fork the repo.
2. Create a branch: `git checkout -b feature/my-thing`.
3. Commit: `git commit -m "feat: add my thing"`.
4. Push: `git push origin feature/my-thing`.
5. Open a PR.

Please keep the script dependency-free — no new runtime requirements without a strong reason.

---

## Legal

Download only content you own, content under a free license, or content you have explicit permission to download. Downloading copyrighted material without authorization violates the platforms' Terms of Service.

This project is a **tool**, not a service. What you do with it is your responsibility.

---

## License

[MIT](https://license/) © 2026 [storm2801](https://github.com/storm2801)

---

## Credits

- Built on top of [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) and [`ffmpeg`](https://ffmpeg.org/).
- Terminal UI inspired by the simplicity of `git`, `tig`, and `lazygit`.
- Progress bar and menu patterns inspired by Unix tools that get out of the way.

</BDS:create_file>
<BDS:create_file fileName="CHANGELOG.md">

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] — 2026-11-09

### Added

- Multi-platform support: Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud, Dailymotion
- Platform detection shown in the summary header
- `install.sh` script for clone-and-install flow
- Status badges in README
- MIT license

### Changed

- Progress bar rewritten: one bar per stream, percentage never decreases
- Quality detection now queries the actual video before offering choices
- Ctrl+C kills `yt-dlp` and cleans temp files
- Banner capitalized to **Siphon**

### Fixed

- URL prompt no longer leaks into the download argument
- Bash 3.2 compatibility (removed `${var^^}` syntax)

## [1.0.0] — 2026-11-09

### Added

- Initial release
- YouTube support with real quality detection
- Video (MP4/MKV) and audio (MP3/WAV/M4A) modes
- Subtitle embedding and sidecar `.srt` export
- Playlist support
- Interactive menu UI with color and clean progress bar
- Ctrl+C cancellation

[Unreleased]: https://github.com/storm2801/siphon/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/storm2801/siphon/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/storm2801/siphon/releases/tag/v1.0.0

