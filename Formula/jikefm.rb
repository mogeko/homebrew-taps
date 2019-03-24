class Jikefm < Formula
  desc "JIKEFM - 即刻电台📻"
  homepage "https://github.com/0neSe7en/jikefm"
  version "v0.3.1"
  url "https://github.com/0neSe7en/jikefm/archive/#{version}.tar.gz"
  sha256 "52d8dbc66ffaa2f696a8501fd0a434701b0e29dc56a27fe72a229f13c135f2d3"

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
