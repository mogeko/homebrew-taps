class Stegify < Formula
  desc "Go tool for LSB steganography, capable of hiding any file within an image."
  version "v1.2"
  homepage "https://github.com/DimitarPetrov/stegify"
  url "https://github.com/DimitarPetrov/stegify/archive/#{version}.tar.gz"
  sha256 "ce692aec6a26b3a757175d9a6092feb625aefadb2f76c9e60c10caf7f19ab316"

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
