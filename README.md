# siphon

> **Draw the media you want, clean.**

A clean, professional terminal downloader for **macOS**. Paste a link, pick what you want, watch a progress bar. No ads, no popups, no sketchy browser extensions.

Works with **YouTube, Instagram, TikTok, Facebook, X (Twitter), Reddit, Vimeo, Twitch, SoundCloud, Dailymotion**, and everything else that [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) supports.

---

## Demo

```

siphon  ·  multi-platform downloader  v1.1.0
──────────────────────────────────────────────────

Pega la URL del vídeo:

> https://youtu.be/dQw4w9WgXcQ

/  Obteniendo información…

──────────────────────────────────────────────────
Plataforma    YouTube
Título        Artist — Song Title
Duración      4m 12s
Calidades     2160p · 1440p · 1080p · 720p · 480p
──────────────────────────────────────────────────

¿Vídeo o audio?

1. Vídeo
2. Audio

> 1

...

¿Descargar ahora? [S/n] s

▸ Vídeo  Artist — Song Title [dQw4w9WgXcQ].f401.mp4
[████████████████████████████████] 100%
▸ Audio  Artist — Song Title [dQw4w9WgXcQ].f140.m4a
[████████████████░░░░░░░░░░░░░░░░]  48%
· Combinando pistas…

✓  Descarga completada

```

---

## Features

- **Multi-platform** — paste a link from YouTube, Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud… if `yt-dlp` supports it, siphon handles it.
- **Real quality detection** — asks the video first and only offers the resolutions that actually exist. No "format not available" surprises.
- **Video or audio** — full video in MP4/MKV, or extract just the audio as MP3, WAV, or M4A.
- **Subtitles** — embed them in the video or save as `.srt` sidecars. Spanish, English, or both.
- **Playlists** — paste a playlist URL and download everything with numbered filenames.
- **Clean progress bar** — a single line per stream that fills up. Not a wall of `[download] 5.3% of ...` noise.
- **Ctrl+C cancels** — at any step. Kills `yt-dlp`, cleans temp files, exits cleanly.
- **DaVinci-friendly audio** — WAV 48 kHz stereo, ready for a timeline with zero conversion.
- **Zero config** — one command, interactive menus, no flags to remember.

---

## Install

### Requirements

- **macOS** (Ventura, Sonoma, Sequoia — or any recent release)
- [Homebrew](https://brew.sh)
- `yt-dlp` and `ffmpeg`

```bash
brew install yt-dlp ffmpeg
```

### From source

```
git clone https://github.com/storm2801/siphon.git
cd siphon
bash install.sh
source ~/.zshrc
```

The installer:

1. Checks for `yt-dlp` and `ffmpeg`, offers to install them via Homebrew if missing.
2. Copies `siphon` to `~/bin/siphon` and marks it executable.
3. Adds `~/bin` to your `PATH` in `~/.zshrc` (idempotent — safe to run twice).

### Manual install

```
mkdir -p ~/bin
cp siphon ~/bin/siphon
chmod +x ~/bin/siphon
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

---

## Usage

```
siphon
```

Follow the prompts. When in doubt, press Enter.

### Flags

```
siphon --help
siphon --version
```

### Changing the download folder

Default: `$HOME/Downloads`. Override with `SIPHON_DEST`:

```
SIPHON_DEST=~/Videos siphon
```

Or export it in `~/.zshrc` to make it permanent:

```
export SIPHON_DEST="$HOME/Videos"
```

---

## How it works

siphon is a **thin bash wrapper** around `yt-dlp`. It handles three things:

1. **Asks questions** in a friendly way (menus, colored output, confirmations).
2. **Translates your answers** into `yt-dlp` flags (`-f "bv*[height<=1080]+ba/b"`, `--audio-format mp3`, `--embed-subs`, etc.).
3. **Formats the output** — a clean progress bar instead of raw `yt-dlp` logging.

No dependencies beyond what `yt-dlp` already requires. No Python venv, no Node, no package manager beyond Homebrew.

---

## Technologies

| Layer ↕▾ | Tool ↕▾ | Role ↕▾ |
|---|---|---|
| −Download engine | [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) | Extracts metadata and downloads the streams |
| Media processing | [`ffmpeg`](https://ffmpeg.org/) | Merges video+audio, converts audio, embeds subtitles |
| Metadata parsing | `python3` (stdlib only) | Parses the JSON output of `yt-dlp -J` |
| UI / logic | `bash` (3.2 compatible) | Menus, progress bar, control flow |
⚙

No `node_modules`. No `pip install`. Just the tools that are standard on macOS.

---

## Troubleshooting

| Symptom ↕▾ | Fix ↕▾ |
|---|---|
| −`Sign in to confirm you're not a bot` | `yt-dlp --cookies-from-browser safari "URL"` (or `chrome`, `firefox`) |
| "Format not available" or only 720p | `brew upgrade yt-dlp` |
| Download stalls mid-way | Re-run `siphon`: `--continue` resumes |
| `siphon: command not found` | `source ~/.zshrc`, or open a fresh terminal |
| Video imports to DaVinci with no audio | Choose **WAV** in the audio menu (M4A/AAC and Opus often fail in Resolve) |
| Progress bar flickers or resets | Rare — happens when the server sends an unexpected header. Let it finish. |
| macOS blocks the script | System Settings → Privacy & Security → "Allow anyway" |
⚙

---

## Roadmap

- ☑  
**v1.0** — YouTube support, quality detection, subtitle control
- ☑  
**v1.1** — Multi-platform (Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud…)
- □  
**v1.2** — Batch mode: read URLs from a file
- □  
**v1.3** — Config file (`~/.siphonrc`) to remember preferences
- □  
**v2.0** — Linux support

---

## Legal

Download only content you own, content under a free license, or content you have explicit permission to download. Downloading copyrighted material without authorization violates the platforms' Terms of Service.

This project is a **tool**, not a service. What you do with it is your responsibility.

---

## License

[MIT](https://license/) © 2026 storm2801

---

## Credits

- Built on top of the excellent [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) and [`ffmpeg`](https://ffmpeg.org/).
- Terminal UI inspired by the simplicity of `git`, `tig`, and `lazygit`.

</BDS:create_file>
<BDS:create_file fileName="LICENSE">

```text
MIT License

Copyright (c) 2026 storm2801

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

