# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] — 2026-11-11

### Added

- Batch mode: `siphon --batch urls.txt` downloads every URL in a text file

## [1.2.0] — 2026-11-11

### Added

- Clipboard fallback: pressing Enter on the URL prompt pulls the URL from the clipboard (`pbpaste`)
- ETA and transfer speed shown next to the percentage in the progress bar

### Changed

- Progress bar clears trailing characters when speed or ETA become unknown
- URL prompt hint now reads `[Enter = portapapeles]`

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

[Unreleased]: https://github.com/storm2801/siphon/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/storm2801/siphon/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/storm2801/siphon/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/storm2801/siphon/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/storm2801/siphon/releases/tag/v1.0.0
