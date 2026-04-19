class Deskpulse < Formula
  desc "Work-presence helper agent for macOS"
  homepage "https://github.com/aresukio/deskpulse"
  url "https://github.com/julianiaccopucci/deskpulse/archive/refs/tags/14.tar.gz"
  sha256 "e8c0604431cfe8cbe7466062020f9dee2eb8fd0af5bf65d2af3ce159f714fe04"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "DeskPulseAgent.swift", "-O", "-o", "deskpulse-agent"
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
