class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.17.0"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "5f634107b61c49513a0d95681e3774c1b7ae4beff9eba3025f6397fcc26b01bb"

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
