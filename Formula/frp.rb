class Frp < Formula
  desc "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."
  homepage "https://github.com/fatedier/frp"
  version "0.24.1"
  url "https://github.com/fatedier/frp/archive/#{version}.tar.gz"
  sha256 "356ec7880f506fe9978f14f866285b6873c2ede2e08e571bc7ea7f1baff570ed"

  depends_on "go" => :build

  def install
    system "make"
    bin.install "bin/frps"
    bin.install "bin/frpc"
  end

  test do
    output_s = shell_output("#{bin}/frps -v")
    assert_match "#{version}", output_s
    output_c = shell_output("#{bin}/frpc -v")
    assert_match "#{version}", output_c
    system "frps", "-v"
    system "frpc", "-v"
  end
end
