class CodexCleaner < Formula
  desc "Prune old generated Codex state with a dry-run preview"
  homepage "https://github.com/msdx321/codex-cleaner"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.0.0/codex-cleaner-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "47067d60db524440967dbe999c50b1085a7b6c5535dc06974ee7af96d4f2d0d1"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.0.0/codex-cleaner-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "4b41f790d14901cf85e563ad515b5c7d2151e11b66f7de46bc9f4f4bd528fcaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.0.0/codex-cleaner-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a1346784157502430bb2df7e5d5479e8729cd9c5cb7927e8c92aa0eefa89f34d"
    end

    on_intel do
      url "https://github.com/msdx321/codex-cleaner/releases/download/v1.0.0/codex-cleaner-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2cc17456a65132fbb5988dc102a9a8f8d32a6c63fae2129e95e0f30eef12914"
    end
  end

  def install
    bin.install "codex-cleaner"
  end
end
