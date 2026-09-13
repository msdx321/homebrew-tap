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

Cleanup defaults to dry-run. Review its output and quit Codex before running
`codex-cleaner --apply`. The formula builds from source with Rust and supports
macOS and Linux. Use `brew upgrade codex-cleaner` after `brew update` to upgrade,
or `brew uninstall codex-cleaner` to remove the tool without changing Codex data.

Publishing a stable codex-cleaner release runs its **Update Homebrew tap** workflow.
The updater validates the source archive's package version and records its SHA-256;
an existing release with a changed checksum is rejected. It pushes the formula
update using `HOMEBREW_TAP_DEPLOY_KEY` configured in the codex-cleaner repository.

The tap's **Verify codex-cleaner release** CI runs only on pushes to `main` that
change `Formula/codex-cleaner.rb`, matching ProxyBear's cask verification pattern.
It runs Homebrew style, audit, installation, and CLI checks. There are no scheduled
or pull-request runs. `brew install --HEAD msdx321/tap/codex-cleaner` builds the
default branch instead of the latest release.
