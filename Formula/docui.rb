class Docui < Formula
  desc "TUI Client for Docker"
  homepage "https://github.com/skanehira/docui"
  version "2.0.4"
  url "https://github.com/skanehira/docui/archive/#{version}.tar.gz"
  sha256 "9af1a720aa7c68bea4469f1d7eea81ccb68e15a47ccfc9c83011a06d696ad30d"

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
