class LocalRunner < Formula
  desc "macOS local job runner with cron scheduling, Web UI, and Slack notifications"
  homepage "https://github.com/gehnmaisoda/local-runner"
  url "https://github.com/gehnmaisoda/local-runner/releases/download/v0.2.0/local-runner-0.2.0-arm64.tar.gz"
  sha256 "dbee35e43aab64229ad7d50e0f722af0ef82b5b8ed200d84c1ba6fb01a07e660"
  version "0.2.0"
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
