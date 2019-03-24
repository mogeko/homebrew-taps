class Jikefm < Formula
  desc "JIKEFM - 即刻电台📻"
  homepage "https://github.com/0neSe7en/jikefm"
  version "v0.3.0"
  url "https://github.com/0neSe7en/jikefm/archive/#{version}.tar.gz"
  sha256 "2d74c4141d7d7b4a99fa6538a65244170c1afb898cad34ce0827b2bb549ac0d2"

  depends_on "go" => :build

  def install
    # ENV["GO111MODULE"] = "on"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "go", "build", "-o", "bin/jikefm"

    bin.install "bin/jikefm"
  end

  test do
    system "false"
  end
end
