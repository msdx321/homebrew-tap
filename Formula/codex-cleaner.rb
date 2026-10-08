class CodexCleaner < Formula
  desc "Prune old generated Codex state with a dry-run preview"
  homepage "https://github.com/msdx321/codex-cleaner"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.0/codex-cleaner-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "77a56df80ac91d0763283438a62b6884f0293a3da241530f59494c183dcdab29"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.0/codex-cleaner-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "83faef3acde9d1769e58518b8f0fbc5ffe53acec4e654505a7baad0c8aafdfb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.0/codex-cleaner-v1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bfa54ceacd16e95edd7e5e6ee2ba76570298823fecc56fe1c7b8cdfa3bc1783c"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.0/codex-cleaner-v1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b98b423d5fa685abe4a72b369f5bca79b4667339b299368a10df6de131c7c4e0"
    end
  end

  def install
    bin.install "codex-cleaner"
  end
end
