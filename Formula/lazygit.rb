class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.10.6"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "7736baea4fec708d92fa14ff78d41d05b9e54aa7fa71b12d0fecda69c365c62c"

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
