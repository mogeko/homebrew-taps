class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.20"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "36689f98b0bbb9e227cf80daa802739c77e5f8a2cc2690fdcffb3c8598a4aa95"

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
