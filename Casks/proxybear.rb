cask "proxybear" do
  version "1.2.4"
  sha256 "d7389d4b1afb7c00473f0a99830ca3eda6ff918d20a2bfbd30e1c40cdfa45cbc"

  url "https://github.com/msdx321/proxybear/releases/download/v#{version}/ProxyBear-#{version}.dmg"
  name "ProxyBear"
  desc "Menu-bar SOCKS5 proxy over SSH"
  homepage "https://github.com/msdx321/proxybear"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "ProxyBear.app"

  uninstall launchctl: "com.msdx321.proxybear",
            quit:      "com.msdx321.proxybear"

  zap trash: "~/Library/Application Support/proxybear"
end
