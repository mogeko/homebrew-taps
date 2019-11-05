class Kcptun < Formula
  desc "A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
  homepage "https://github.com/xtaci/kcptun"
  version "v20191105"
  url "https://github.com/xtaci/kcptun/archive/#{version}.tar.gz"
  sha256 "eebfd41933b0f7c9e4235989b19528bb59a1039dc0599f48eee0fad394512148"

  depends_on "go" => :build

  def install
    # ENV["GO111MODULE"] = "on"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "go", "build", "-o", "bin/kcptunc", "./client"
    system "go", "build", "-o", "bin/kcptuns", "./server"

    bin.install "bin/kcptunc"
    bin.install "bin/kcptuns"
  end

  test do
    client_version = shell_output("#{bin}/kcptunc -v")
    assert_match "kcptun version SELFBUILD", client_version
    server_version = shell_output("#{bin}/kcptuns -v")
    assert_match "kcptun version SELFBUILD", server_version
    system "kcptunc", "-v"
    system "kcptuns", "-v"
  end
end
