class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.19"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "6db21f6bd3d39f476cc9b7e8ac309cb2506b20b7c171be65baba7fa39a4df562"

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
