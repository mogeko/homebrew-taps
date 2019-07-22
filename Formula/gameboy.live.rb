class Docui < Formula
  desc "A basic gameboy emulator with terminal \"Cloud Gaming\" support"
  homepage "https://github.com/HFO4/gameboy.live"
  version "0.1"
  url "https://github.com/HFO4/gameboy.live/archive/#{version}.tar.gz"
  sha256 "556c1b6cf5e9093ed309fdfc9ffa85cfeef6bbe6e2cfd858b2ec07134484aa62"

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "go", "build", "-o", "gbdotlive", "main.go"

    bin.install "gbdotlive"
  end

  test do
    system "gbdotlive" "-h"
  end
end
