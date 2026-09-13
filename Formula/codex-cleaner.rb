class CodexCleaner < Formula
  desc "Prune old generated Codex state with a dry-run preview"
  homepage "https://github.com/msdx321/codex-cleaner"
  url "https://github.com/msdx321/codex-cleaner/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "aa12f8ef40a864135d232c72732c91d16101b1f12124903678270eb1100c4b5e"
  license "MIT"
  head "https://github.com/msdx321/codex-cleaner.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end
end
