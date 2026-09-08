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
