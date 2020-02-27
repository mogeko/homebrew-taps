class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.15.6"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "703f5d0ceb7451bc6b6755edb1350421a91451054641f822d1f021e731227986"

  depends_on "go" => :build
  depends_on "git"

  def install
    ENV["GO111MODULE"] = "auto"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "go", "build", "-o", "bin/lazygit"

    bin.install "bin/lazygit"
  end

  test do
    system "#{bin}/lazygit", "-v"
  end
end
