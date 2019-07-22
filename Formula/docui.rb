class Docui < Formula
  desc "TUI Client for Docker"
  homepage "https://github.com/skanehira/docui"
  version "1.0.3"
  url "https://github.com/skanehira/docui/archive/#{version}.tar.gz"
  sha256 "02d6c77eca87917a51ddd1ba40afe26d9df33cb07f7de8cdf10726359276aa94"

  depends_on "go" => :build
  # depends_on "docker"

  def install
    ENV["GO111MODULE"] = "auto"
    ENV["GOPROXY"] = "https://goproxy.io"
    system "make"

    bin.install "docui"
  end

  def caveats; <<~EOS
    Please make sure Docker is installed on your computer.
    If NOT, you can install it by
        brew cask install docker
  EOS
  end

  test do
    system "docui", "--help"
  end
end
