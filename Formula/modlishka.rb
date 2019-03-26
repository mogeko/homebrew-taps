class Modlishka < Formula
  desc "Modlishka. Reverse Proxy. Phishing NG."
  homepage "https://github.com/drk1wi/Modlishka"
  version "v.1.0.0"
  url "https://github.com/drk1wi/Modlishka/archive/#{version}.tar.gz"
  sha256 "4561105d340c08256a41953e6bbc2b93afb3b5474b64c7e28e1aebb185d99dba"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/drk1wi").mkpath
    ln_s buildpath, buildpath/"src/github.com/drk1wi/Modlishka"
    system "go", "get", "github.com/drk1wi/Modlishka"

    bin.install "bin/Modlishka"
  end

  test do
    system "false"
  end
end
