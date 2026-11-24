cask "snap-desk" do
  version "0.3.1"
  sha256 "5d0fc3c2bd426f19dde66874d5beb319749f9d19dff20e98dfbaecddb8d42dd3"

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
