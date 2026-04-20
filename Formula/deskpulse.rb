class Deskpulse < Formula
  desc "Work-presence helper agent for macOS"
  homepage "https://github.com/aresukio/homebrew-deskpulse"
  url "https://github.com/aresukio/homebrew-deskpulse/releases/download/28/deskpulse-28-macos-arm64.tar.gz"
  version "28"
  sha256 "edf1da7dfe43de195a099d62b5800e3b7244adf3350251188750c3d59c4aab2e"
  license "MIT"

  depends_on :macos

  def install
    bin.install "deskpulse-agent"
    bin.install "deskpulse"
  end

  service do
    run [opt_bin/"deskpulse-agent"]
    keep_alive true
    working_dir var/"deskpulse"
    log_path var/"log/deskpulse-out.txt"
    error_log_path var/"log/deskpulse-err.txt"
    environment_variables(
      DESKPULSE_LAUNCH_LABEL: "homebrew.mxcl.deskpulse",
      DESKPULSE_OUT_LOG_PATH: var/"log/deskpulse-out.txt",
      DESKPULSE_ERR_LOG_PATH: var/"log/deskpulse-err.txt",
    )
  end

  test do
    assert_match "deskpulse - Manage DeskPulse", shell_output("#{bin}/deskpulse help")
  end
end
