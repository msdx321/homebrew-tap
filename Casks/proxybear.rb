cask "proxybear" do
  version "1.3.0"
  sha256 "422b551d500bf849beb4b58078d1f7a03db9266f817efbd3a511a8e8c805bbf9"

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
