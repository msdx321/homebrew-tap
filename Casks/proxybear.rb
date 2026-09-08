cask "proxybear" do
  version "0.3.0"
  sha256 "a324b128726a1e53a721d66fce092924d246d7ab923c66a277a3b2992bcc6f2c"

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
