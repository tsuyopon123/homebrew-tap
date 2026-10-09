cask "wifisight" do
  version "0.1.1"
  sha256 "63d52e9146ff145ddff467755f93db47039c5eec84dd3ef5d452b369d9048031"

  url "https://github.com/tsuyopon123/wifisight/releases/download/v#{version}/WiFiSight_#{version}_universal.dmg"
  name "WiFiSight"
  desc "Cross-platform Wi-Fi scanner for event NOCs"
  homepage "https://github.com/tsuyopon123/wifisight"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :big_sur

  app "WiFiSight.app"

  # not notarized: drop quarantine so Gatekeeper doesn't block the first launch
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/WiFiSight.app"],
                          writable_paths: ["WiFiSight.app"], writable_base: :appdir
  end

  zap trash: [
    "~/Library/Application Support/dev.tsuyopon.wifisight",
    "~/Library/Caches/dev.tsuyopon.wifisight",
    "~/Library/WebKit/dev.tsuyopon.wifisight",
  ]
end
