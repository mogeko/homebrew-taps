class Frp < Formula
  desc "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."
  homepage "https://github.com/fatedier/frp"
  version "v0.31.2"
  url "https://github.com/fatedier/frp/archive/#{version}.tar.gz"
  sha256 "790a18f5651cc645a3d73fc147c719f5b212fc21db0c51c620011ee836b7a28f"

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
