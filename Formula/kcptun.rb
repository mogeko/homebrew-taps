class Kcptun < Formula
  desc "A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
  homepage "https://github.com/xtaci/kcptun"
  version "v20190713"
  url "https://github.com/xtaci/kcptun/archive/#{version}.tar.gz"
  sha256 "45c15938d4be18205dba98cb44d86d2125367f9f901c88d635de8f5b3e2a5ae2"

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
