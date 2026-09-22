cask "proxybear" do
  version "1.0.2"
  sha256 "b7a0a20024b494312d82b1bda87901fdfe7aaff5360908f58f4d4e0bd50581ad"

  url "https://github.com/msdx321/proxybear/releases/download/v#{version}/ProxyBear-#{version}.dmg"
  name "ProxyBear"
  desc "Menu-bar SOCKS5 proxy over SSH"
  homepage "https://github.com/msdx321/proxybear"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "ProxyBear.app"

  uninstall launchctl: "com.msdx321.proxybear",
            quit:      "com.msdx321.proxybear"

  zap trash: "~/Library/Application Support/proxybear"
end
