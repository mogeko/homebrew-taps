class BaidupcsGo < Formula
  desc "仿 Linux shell 文件处理命令的百度网盘命令行客户端"
  homepage "https://github.com/iikira/BaiduPCS-Go"
  version "3.5.6"
  url "https://github.com/iikira/BaiduPCS-Go/archive/v#{version}.tar.gz"
  sha256 "0b2abd18c5101d5255faa31c713cbebad3804af07c1a008a5b9b799060beb12a"
  head "https://github.com/iikira/BaiduPCS-Go.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/iikira").mkpath
    ln_s buildpath, buildpath/"src/github.com/iikira/BaiduPCS-Go"
    system "go", "get", "github.com/iikira/BaiduPCS-Go"

    bin.install "bin/BaiduPCS-Go"

    bin.install_symlink "BaiduPCS-Go" => "baidupcs"
  end

  test do
    system "#{bin}/BaiduPCS-Go", "--version"
    system "#{bin}/baidupcs", "--version"
  end
end
