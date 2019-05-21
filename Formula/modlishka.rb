class Modlishka < Formula
  desc "Modlishka. Reverse Proxy. Phishing NG."
  homepage "https://github.com/drk1wi/Modlishka"
  version "v.1.1.0"
  url "https://github.com/drk1wi/Modlishka/archive/#{version}.tar.gz"
  sha256 "ef527fce959bdb0b19cef0c9213a8efb4f95ce2d404587d21e3931c7d7ea5cd1"

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
