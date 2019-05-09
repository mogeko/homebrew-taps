class Docui < Formula
  desc "TUI Client for Docker"
  homepage "https://github.com/skanehira/docui"
  version "1.0.3"
  url "https://github.com/skanehira/docui/archive/#{version}.tar.gz"
  sha256 "044ce6c54cf8b8bae6165942c8ff87d51594abc246863f00b5201e8cc538af79"

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
