class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.14.3"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "9ff8672aff431f5ccd943cc2a87877950b1efd7e9987a3c024c9b626a2a7ee81"

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
