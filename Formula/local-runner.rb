class LocalRunner < Formula
  desc "macOS local job runner with cron scheduling, Web UI, and Slack notifications"
  homepage "https://github.com/gehnmaisoda/local-runner"
  url "https://github.com/gehnmaisoda/local-runner/releases/download/v0.4.0/local-runner-0.4.0-arm64.tar.gz"
  sha256 "c41a75ca73ce6422080c6cfb2ce597c311530c1c474a5ec7a0d2a5bab8398858"
  version "0.4.0"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    prefix.install "LocalRunner.app"
    bin.install "lr"
  end

  def caveats
    <<~EOS
      サービスの管理:
        lr install     # デーモンを LaunchAgent として登録・起動
        lr uninstall   # LaunchAgent を解除
        lr doctor      # セットアップの診断
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lr --version")
  end
end
