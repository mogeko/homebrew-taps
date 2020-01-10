class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.13"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "93ca0847cd91874228b023d9feb967aaa819532f173fd6e19e2d00b8a6242e3c"

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
