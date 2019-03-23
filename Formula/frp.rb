class Frp < Formula
  desc "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."
  homepage "https://github.com/fatedier/frp"
  version "v0.25.1"
  url "https://github.com/fatedier/frp/archive/#{version}.tar.gz"
  sha256 "33bda2e559f072e8423d8ef84a66b150c4a5fe986c892cbdd8b5bebe2f7956be"

  depends_on "go" => :build

  def install
    # ENV["GO111MODULE"] = "on"
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
