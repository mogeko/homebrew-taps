class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.12.3"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "0338c29be43ab1393ed9dfcda20a93c44f40753c26c8e516b6ed7f79f7275ec4"

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
