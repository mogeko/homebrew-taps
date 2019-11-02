class Frp < Formula
  desc "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."
  homepage "https://github.com/fatedier/frp"
  version "v0.29.1"
  url "https://github.com/fatedier/frp/archive/#{version}.tar.gz"
  sha256 "ac95f0b204da2fa1116ce0f30c3caa46a2fa280bce0cb91e8f46690b065e5665"

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "make"
    bin.install "bin/frps"
    bin.install "bin/frpc"
  end

  test do
    output_s = shell_output("#{bin}/frps -v")
    assert_match "#{version}", "v"+output_s
    output_c = shell_output("#{bin}/frpc -v")
    assert_match "#{version}", "v"+output_c
    system "frps", "-v"
    system "frpc", "-v"
  end
end
