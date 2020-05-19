class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.20.4"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "8af316bf9d0916e8b19ce590a80664314a38652af9ef115083686bc9720fa7b9"

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
