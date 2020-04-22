class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.20.2"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "ee99f77ae67129764835e6d85afd71a4f91c61a06952a891fe8fb46d8d5425e4"

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
