class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.15.7"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "dbec001beb1b1b382cfc0d30a1d6c38bd9fa88cd7aa7aebaaeebe592b4ed487d"

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
