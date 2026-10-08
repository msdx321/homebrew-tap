class CodexCleaner < Formula
  desc "Prune old generated Codex state with a dry-run preview"
  homepage "https://github.com/msdx321/codex-cleaner"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.1/codex-cleaner-v1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "7c559092a7174eb1016df5f54dfe6dfd740b3f841a14a5cc63a63a5067bba652"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.1/codex-cleaner-v1.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "37b7fbdea58a333b536fd54f5f4d2f31a3f9091d597d3bbdd27b90639b4001f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.1/codex-cleaner-v1.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8764b1cbff1d084dd1edfce959d7e82e581706e569a9d14a48795ca83ed66925"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.1.1/codex-cleaner-v1.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48df3194a2d3c454b4829116a375b0a025c1484ffe26a30d5c11bed6bdcd186d"
    end
  end

  def install
    bin.install "codex-cleaner"
  end
end
