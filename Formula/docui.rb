class Docui < Formula
  desc "TUI Client for Docker"
  homepage "https://github.com/skanehira/docui"
  version "2.0.1"
  url "https://github.com/skanehira/docui/archive/#{version}.tar.gz"
  sha256 "03f953365842f94af6ff1fe2949d94036b88d0504daef71f2743b34099457de4"

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
