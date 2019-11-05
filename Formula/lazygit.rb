class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.9"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "33a13cd4c9556e011b6dba68a4e2e7e6dcb59cb6891f6820a41c5b4e24bee42f"

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
