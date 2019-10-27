class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "0.8.3"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "ed6c9992acf36d021cf3fa424f413328192421f311123d5feed7b4122b9f53f2"

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
