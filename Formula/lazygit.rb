class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.8"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "0205046c14edc1de2c01131907e88566cc0c9c6d4714ec57d2b6a46c9bb5f7e6"

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
