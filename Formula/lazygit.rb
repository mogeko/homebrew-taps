class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.8.1"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "274ba05573b38cccc56cb63053eec0972535979b95f1f30b6ca318d991f2c14c"

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
