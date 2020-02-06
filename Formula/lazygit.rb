class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.14.2"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "f377aed6b5e51b6885544a012062ba863d3599e1dab2e7928bea7880c2888e7f"

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
