class Stegify < Formula
  desc "Go tool for LSB steganography, capable of hiding any file within an image."
  version "v1.0"
  homepage "https://github.com/DimitarPetrov/stegify"
  url "https://github.com/DimitarPetrov/stegify/archive/#{version}.tar.gz"
  sha256 "0bffdca66c1c6b56a069a468d50a24c66e463faf2e21f63408cadd7f0215db3f"

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
