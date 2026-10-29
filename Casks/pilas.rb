# Plantilla del cask de Homebrew. La rellena `node scripts/release.mjs cask`
# en el workflow de release y el resultado se publica en HurgotDev/homebrew-tap.
cask "pilas" do
  version "0.3.0"
  sha256 "420ca95ed3869a9a13baf746d1920be8a6a848c16c6e7f5b7b0e0ca314ef2d8b"

  url "https://github.com/HurgotDev/pilas-app/releases/download/v#{version}/Pilas_#{version}_universal.dmg"
  name "Pilas"
  desc "Notch mascot that tells you when Claude Code needs you"
  homepage "https://github.com/HurgotDev/pilas-app"

  # Pilas se actualiza sola (tauri-plugin-updater): Homebrew no debe pisarla.
  auto_updates true
  depends_on macos: ">= :ventura"

  app "Pilas.app"

  # La app no está firmada con Apple ni notarizada: quitamos la marca de
  # cuarentena para que macOS no bloquee el primer arranque.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pilas.app"]
  end

  zap trash: [
    "~/Library/Application Support/Pilas",
    "~/Library/LaunchAgents/dev.pilas.app.plist",
  ]
end

