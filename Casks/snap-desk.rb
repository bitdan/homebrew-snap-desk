cask "snap-desk" do
  version "0.3.0"
  sha256 "1c78f14906f1bafc39019f46ec74e7d63696de435c60cd294e4ff908fb160ebf"

  url "https://github.com/bitdan/snap-desk/releases/download/v#{version}/snap-desk-v#{version}-macos-arm64.dmg"
  name "Snap Desk"
  desc "Screenshot, pin, OCR and translation tool"
  homepage "https://github.com/bitdan/snap-desk"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Snap Desk.app"

  # 应用使用自签名证书、未经公证：去掉下载隔离标记，否则 Gatekeeper 会提示“已损坏”而无法打开。
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Snap Desk.app"]
  end

  zap trash: [
    "~/Library/Application Support/io.snapdesk.app",
    "~/Library/Caches/io.snapdesk.app",
    "~/Library/Logs/io.snapdesk.app",
  ]
end
