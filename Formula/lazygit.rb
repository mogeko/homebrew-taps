class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.8.2"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "aaaa4cb789d387a08eb46ca95159561cdb4a2f4e70315ce68ed61bbd30fe24ee"

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
