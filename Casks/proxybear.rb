cask "proxybear" do
  version "1.0.1"
  sha256 "bd77758ba7a135814e12d917abce79ff10f1dd37d07c2a9035a22be48a886bfc"

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
