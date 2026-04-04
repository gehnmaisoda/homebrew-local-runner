class LocalRunner < Formula
  desc "macOS local job runner with cron scheduling, Web UI, and Slack notifications"
  homepage "https://github.com/gehnmaisoda/local-runner"
  url "https://github.com/gehnmaisoda/local-runner/releases/download/v0.1.0/local-runner-0.1.0-arm64.tar.gz"
  sha256 "baea6793c401f550f88d9e420c8b96c6878ce78a288f40ac0d438404e744db32"
  version "0.1.0"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "local-runner-daemon"
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
