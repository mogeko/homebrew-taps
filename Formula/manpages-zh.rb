class ManpagesZh < Formula
  desc "Chinese Manual Pages"
  homepage "https://github.com/man-pages-zh/manpages-zh"
  version "v1.6.3.3"
  url "https://github.com/man-pages-zh/manpages-zh/archive/#{version}.tar.gz"
  head "https://github.com/man-pages-zh/manpages-zh.git"
  sha256 "4a3696114f1372157624b27c4f5bf65f67528fc81244b203d75737505156a211"

  depends_on "man-db"
  depends_on "make" => :build
  depends_on "opencc" => :build
  depends_on "python3" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf", "--install"
    system "./configure"
    system "make"
    system "make", "install", "DESTDIR=\"#{buildpath}\""
    man.install "#{buildpath}/usr/local/share/man/zh_CN"
    man.install "#{buildpath}/usr/local/share/man/zh_TW"
  end

  test do
    system "man -w ls"
  end
end
