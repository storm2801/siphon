<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:4D6BFE,100:6E8FFF&height=220&section=header&text=Siphon&fontSize=96&fontColor=ffffff&animation=fadeIn&fontAlignY=40&desc=Draw%20the%20media%20you%20want%2C%20clean.&descAlignY=62&descSize=20" alt="Siphon" />

<div align="center">

**Draw the media you want, clean.**

A minimalist terminal downloader for macOS and Linux. Paste a link, pick what you want, and watch it land.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](#installation)
[![CI](https://github.com/storm2801/siphon/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/storm2801/siphon/actions/workflows/shellcheck.yml)

</div>

---

## Installation

### macOS

Open Terminal and paste this single line to install Siphon and its dependencies:

```bash
curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash
```

*(Alternatively, download the `Siphon.command` file from the repo, right-click -> Open, and it will install automatically without using the Terminal).*

### Linux

First, install the required dependencies for your distribution:

**Ubuntu / Debian / Mint:**
```bash
sudo apt update && sudo apt install -y yt-dlp ffmpeg curl
```

**Fedora / RHEL:**
```bash
sudo dnf install -y yt-dlp ffmpeg curl
```

**Arch / Manjaro:**
```bash
sudo pacman -S --noconfirm yt-dlp ffmpeg curl
```

**openSUSE:**
```bash
sudo zypper install -y yt-dlp ffmpeg curl
```

Then, run the Siphon installer:

```bash
curl -fsSL https://raw.githubusercontent.com/storm2801/siphon/main/install.sh | bash
```

---

## Usage

Just type `siphon` in your terminal:

```bash
siphon
```

It will ask you for a URL, if you want video or audio, the quality, and the format. Press **`q`** at any URL prompt to exit.

## What it does

- **Multi-platform:** YouTube, Instagram, TikTok, Facebook, X, Reddit, Vimeo, Twitch, SoundCloud, and more.
- **Real quality detection:** Checks the video first so you only see the resolutions that actually exist.
- **Video or audio:** Download full videos in MP4/MKV, or extract audio as MP3, WAV, or M4A (perfect for DaVinci Resolve).
- **Subtitles:** Download as `.srt` files or embed them directly into the video.
- **Duplicate protection:** If the file already exists, it asks you if you want to cancel or download a renamed copy.
- **Batch mode:** Have a list of URLs? Run `siphon --batch urls.txt` to download them all at once.
- **Self-update:** Run `siphon --update` to get the latest version.
- **Clipboard support:** Just press Enter at the URL prompt to paste the last link you copied.

## Uninstall

```bash
rm ~/bin/siphon
```
*(Then remove the `# siphon` block from your `~/.zshrc` on macOS or `~/.bashrc` on Linux).*

---

## License

[MIT](LICENSE) © 2026 [storm2801](https://github.com/storm2801).

Built on top of [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [ffmpeg](https://ffmpeg.org).
