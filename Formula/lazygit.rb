class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.10.2"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "d9f830e2a121cd3314fd83633057110fcb2ccca1f3e655a8d5ff15ed426ff125"

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
