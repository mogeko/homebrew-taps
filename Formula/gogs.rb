class Gogs < Formula
  desc "Gogs is a painless self-hosted Git service."
  homepage "https://gogs.io"
  version "v0.11.91"
  url "https://github.com/gogs/gogs/archive/#{version}.tar.gz"
  sha256 "6808db68a5952504b81f35fda29ddadde676a91d792262dcf7c3d90be85453eb"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gogs").mkpath
    ln_s buildpath, buildpath/"src/github.com/gogs/gogs"
    system "go", "get", "github.com/gogs/gogs"
    bin.install "bin/gogs"
  end

  test do
    output = shell_output("#{bin}/gogs -v")
    assert_match "Gogs version #{version}.0130", "v"+output
    system "gogs", "-v"
  end
end
