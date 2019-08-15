class Docui < Formula
  desc "TUI Client for Docker"
  homepage "https://github.com/skanehira/docui"
  version "2.0.0"
  url "https://github.com/skanehira/docui/archive/#{version}.tar.gz"
  sha256 "2bbe699c43f998fae54222e9114302bf7298072b7548ef8a361198bbda13b656"

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
