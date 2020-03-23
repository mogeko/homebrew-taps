class Lazygit < Formula
  desc "simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit"
  version "v0.17.4"
  url "https://github.com/jesseduffield/lazygit/archive/#{version}.tar.gz"
  sha256 "75b8ee9d22d7b910704a4ab7012efcc2e9c24d1ba51488ef99a236a9bcb61cad"

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
