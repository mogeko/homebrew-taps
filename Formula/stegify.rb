class Stegify < Formula
  desc "Go tool for LSB steganography, capable of hiding any file within an image."
  version "v1.1"
  homepage "https://github.com/DimitarPetrov/stegify"
  url "https://github.com/DimitarPetrov/stegify/archive/#{version}.tar.gz"
  sha256 "33c4111447a0e2538e211c1b787b726e895b57a2f25a4f7a11002e1f3357d1f4"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/DimitarPetrov").mkpath
    ln_s buildpath, buildpath/"src/github.com/DimitarPetrov/stegify"
    system "go", "get", "github.com/DimitarPetrov/stegify"

    bin.install "bin/stegify"
  end

  test do
    system "false"
  end
end
