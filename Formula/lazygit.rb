class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.17.3"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "787692599278f3ad29b0c7d98b5a4401a3b919abe72242a47fae9d95b884faa9"

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
