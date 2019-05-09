class Frp < Formula
  desc "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."
  homepage "https://github.com/fatedier/frp"
  version "v0.27.0"
  url "https://github.com/fatedier/frp/archive/#{version}.tar.gz"
  sha256 "5d2efd5d924c7a7f84a9f2838de6ab9b7d5ca070ab243edd404a5ca80237607c"

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
