class Kcptun < Formula
  desc "A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
  homepage "https://github.com/xtaci/kcptun"
  version "v20190515"
  url "https://github.com/xtaci/kcptun/archive/#{version}.tar.gz"
  sha256 "2c9573453b09a64852e33404a2dfe45f96e5f49e547678c7b13549cfff41cae7"

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
