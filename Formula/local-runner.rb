class LocalRunner < Formula
  desc "macOS local job runner with cron scheduling, Web UI, and Slack notifications"
  homepage "https://github.com/gehnmaisoda/local-runner"
  url "https://github.com/gehnmaisoda/local-runner/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "005c431c24aa256e602017c460df457206960efd18dc6a75b7ff57f38fa4762a"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["15.0", :build]
  depends_on "bun" => :build

  def install
    # Daemon (Swift)
    cd "daemon" do
      system "swift", "build", "-c", "release", "--disable-sandbox"
      bin.install ".build/release/local-runner" => "local-runner-daemon"
    end

    # CLI (Bun → single binary)
    cd "cli" do
      system "bun", "install"
      system "bun", "build", "--compile", "index.ts", "--outfile", "lr",
             "--define", "__EMBEDDED_VERSION__=\"#{version}\""
      bin.install "lr"
    end
  end

  service do
    run [opt_bin/"local-runner-daemon"]
    keep_alive true
    restart_delay 10
    log_path var/"log/local-runner/daemon.stdout.log"
    error_log_path var/"log/local-runner/daemon.stderr.log"
    working_dir var/"local-runner"
  end

  def post_install
    (var/"log/local-runner").mkpath
    (var/"local-runner").mkpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lr --version")
  end
end
