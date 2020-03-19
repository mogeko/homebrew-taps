class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.17.1"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "5afe88abb84b80956e24ffbc60819a9ecf5bf80a1fbf06238abd049d9e3c4682"

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
