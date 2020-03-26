class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.18"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "48f44051cacab508ca53cc2c3aaeabc01b61b4a02379bac1a0eb8be630a7af51"

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
