class BaidupcsGo < Formula
  desc "仿 Linux shell 文件处理命令的百度网盘命令行客户端"
  homepage "https://github.com/iikira/BaiduPCS-Go"
  version "v3.6.1"
  url "https://github.com/iikira/BaiduPCS-Go/archive/#{version}.tar.gz"
  sha256 "07e1d802e6b49425a53b883c354d8b753de55f7005ac8c7b27cd8396db0447da"
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
    output = shell_output("#{bin}/BaiduPCS-Go --version 2>&1")
    assert_match "BaiduPCS-Go version #{version}-devel", output
    system "#{bin}/baidupcs", "--version"
    system "BaiduPCS-Go", "--version"
    system "baidupcs", "--version"
  end
end
