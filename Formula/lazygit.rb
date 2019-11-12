class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.10.5"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "ee94e54d7955b61b5049742a0f655a16ec29c06fcf7f1b5ec82410052289e5e8"

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
