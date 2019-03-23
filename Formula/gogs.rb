class Gogs < Formula
  desc "Gogs is a painless self-hosted Git service."
  homepage "https://gogs.io"
  version "v0.11.86"
  url "https://github.com/gogs/gogs/archive/#{version}.tar.gz"
  sha256 "1745610d42a2ec6dd7d6e306ae7a1b120e5fbcb646c06738b332cc99f170b152"

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
