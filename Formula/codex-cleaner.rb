class CodexCleaner < Formula
  desc "Prune old generated Codex state with a dry-run preview"
  homepage "https://github.com/msdx321/codex-cleaner"
  url "https://github.com/msdx321/codex-cleaner/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "ce2839e1bdd5d15bda3689c924a50fb77031a6f508abb738fff76b0560778d20"
  license "MIT"
  head "https://github.com/msdx321/codex-cleaner.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end
end
