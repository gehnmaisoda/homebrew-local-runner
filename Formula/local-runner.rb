class LocalRunner < Formula
  desc "macOS local job runner with cron scheduling, Web UI, and Slack notifications"
  homepage "https://github.com/gehnmaisoda/local-runner"
  url "https://github.com/gehnmaisoda/local-runner/releases/download/v0.3.1/local-runner-0.3.1-arm64.tar.gz"
  sha256 "b31b57658768f6392a39a9c5463415d899187a7d0ce6af9aa0e728b05fc0181f"
  version "0.3.1"
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
