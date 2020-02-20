class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.14.4"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "43008dd4ef764ed1f6a5c62a03a541fdf257338a8f4df13cb8dc51ea8e31ca3d"

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
