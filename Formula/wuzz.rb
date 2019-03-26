class Wuzz < Formula
  desc "Interactive cli tool for HTTP inspection"
  homepage "https://github.com/asciimoo/wuzz"
  version "v0.4.0"
  url "https://github.com/asciimoo/wuzz/archive/#{version}.tar.gz"
  sha256 "acf8e82481740d1403b744c58918b9089128d91c3c6edc15b76b6e1c97ead645"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/asciimoo").mkpath
    ln_s buildpath, buildpath/"src/github.com/asciimoo/wuzz"
    system "go", "get", "github.com/asciimoo/wuzz"

    bin.install "bin/wuzz"
  end

  test do
    system "#{bin}/wuzz", "--help"
    system "wuzz", "--help"
  end
end
