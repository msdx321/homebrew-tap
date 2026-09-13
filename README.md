# msdx321 Homebrew tap

Install [ProxyBear](https://github.com/msdx321/proxybear), a menu-bar SOCKS5 proxy over SSH:

```sh
brew install --cask msdx321/tap/proxybear
```

The current release requires an Apple Silicon Mac running macOS 11 or later.
Open ProxyBear from Applications and use the bear icon in the menu bar.
For first-launch help, see the [installation instructions](https://github.com/msdx321/proxybear#installation).

To update:

```sh
brew update
brew upgrade --cask msdx321/tap/proxybear
```

To uninstall while keeping settings:

```sh
brew uninstall --cask proxybear
```

To also remove ProxyBear's saved settings and logs, use `brew uninstall --cask --zap proxybear`.

## Release updates

The **Update and verify cask** workflow checks the latest stable ProxyBear release every six hours.
It downloads the DMG, verifies its SHA-256 against the release's `SHA256SUMS`, and updates the cask.
Homebrew style, audit, and installation checks must pass before it commits an update.
You can also run the workflow manually after publishing a release.
It uses this repository's `GITHUB_TOKEN`; no cross-repository token is needed.

## Codex Cleaner

Install the latest published [codex-cleaner](https://github.com/msdx321/codex-cleaner)
release to preview and prune old generated Codex state:

```sh
brew install msdx321/tap/codex-cleaner
codex-cleaner --json
```

Cleanup opens an interactive preview in a terminal by default. Review its output
and quit Codex before applying cleanup. The formula installs CI-built binaries
for Apple Silicon and Intel macOS, and ARM64 and x86-64 Linux (glibc 2.35 or later),
without Rust or LLVM dependencies. Use `brew upgrade codex-cleaner` after `brew update` to upgrade,
or `brew uninstall codex-cleaner` to remove the tool without changing Codex data.

Publishing a stable codex-cleaner release runs its **Update Homebrew tap** workflow.
The updater verifies every binary archive against the release's `SHA256SUMS`;
an existing release with a changed checksum is rejected. It pushes the formula
update using `HOMEBREW_TAP_DEPLOY_KEY` configured in the codex-cleaner repository.

The tap's **Verify codex-cleaner release** CI runs only on pushes to `main` that
change `Formula/codex-cleaner.rb`, matching ProxyBear's cask verification pattern.
It runs Homebrew style, audit, installation, and CLI checks. There are no scheduled
or pull-request runs. Installation checks also require an empty dependency list.
