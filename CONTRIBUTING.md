# Contributing to Siphon

Thanks for wanting to help. Siphon is a small project and every improvement counts.

## Ways to contribute

- **Report bugs** — open an [issue](https://github.com/storm2801/siphon/issues/new?template=bug_report.md)
- **Suggest features** — open an [issue](https://github.com/storm2801/siphon/issues/new?template=feature_request.md)
- **Write code** — fork and send a pull request
- **Improve docs** — README, CHANGELOG, comments in the script
- **Star the repo** — helps visibility more than you'd think

## Code contributions

1. Fork the repository
2. Create a branch: `git checkout -b feat/my-feature`
3. Make your change
4. Run `shellcheck siphon` — it must be clean
5. Test manually (see Testing below)
6. Commit with a descriptive message (see Commit messages below)
7. Push to your fork and open a pull request

## Style guide

- **Bash 3.2 compatible** — macOS ships 3.2 by default. Do not use `${var^^}`, `mapfile`, or associative arrays.
- **No new runtime dependencies** without a strong reason. Siphon currently requires only `yt-dlp`, `ffmpeg`, and the tools that ship with macOS.
- **Run `shellcheck siphon`** before committing. Zero warnings is the target.
- Follow the existing style: 2-space indentation, functions grouped at the top, lowercase variable names.
- **Preserve the `SIPHON_*` env var names** — they are documented and used in CI.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat: add new feature`
- `fix: correct bug`
- `docs: update README`
- `chore: cleanup`
- `ci: tweak workflow`

Short subject (50 characters or less), imperative mood, no period at the end. Body optional but encouraged for non-trivial changes.

## Testing

There is no automated test suite. Before opening a PR, manually verify:

1. `./siphon --version` — prints the version
2. `./siphon --help` — prints usage
3. `HOME=/tmp/testhome ./siphon --init` — creates `~/.siphonrc` correctly
4. `SIPHON_MODE=2 ./siphon --show-config` — shows `mode 2`
5. A basic download from a short public video works end to end
6. `shellcheck siphon` — no warnings

If your change touches the progress bar, the menu, or `run_download`, test on a long video (5+ minutes) so the bar has time to fill.

## Questions

Open an issue or reach out to [@storm2801](https://github.com/storm2801).
