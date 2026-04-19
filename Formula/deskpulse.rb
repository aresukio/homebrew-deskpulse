class Deskpulse < Formula
  desc "Work-presence helper agent for macOS"
  homepage "https://github.com/aresukio/homebrew-deskpulse"
  url "https://github.com/aresukio/homebrew-deskpulse/releases/download/19/deskpulse-macos-arm64.tar.gz"
  sha256 "a58f45f4bf157d0672139e18a7968a3c4caad8ca89314f57b69a8bda062b0aab"
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
