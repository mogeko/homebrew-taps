class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.11.3"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "b3c503de6b34fd4284fd70655e7f42feafc07f090e7f7cc00db261f56c583c46"

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
