class Vlmcsd < Formula
  desc "KMS Emulator in C (currently runs on Linux including Android, FreeBSD, Solaris, Minix, Mac OS, iOS, Windows with or without Cygwin)"
  homepage "http://forums.mydigitallife.info/threads/50234"
  version "svn1112"
  url "https://github.com/Wind4/vlmcsd/archive/#{version}.tar.gz"
  sha256 "e319ab00a559f07a6a74abf13a0b2aeacb97cca052b2bd0065637db567850f7e"
  head "https://github.com/Wind4/vlmcsd.git"

  depends_on "gcc" => :build
  depends_on "make" => :build

  def install
    system "make", "CC=gcc"
    bin.install "bin/vlmcsd"
    bin.install "bin/vlmcs"
    man1.install "man/vlmcs.1"
    man7.install "man/vlmcsd.7"
    man8.install "man/vlmcsd.8"
    man5.install "man/vlmcsd.ini.5"
    # man7.install "man/vlmcsd-floppy.7"
    # man1.install "man/vlmcsdmulti.1"
  end

  test do
    system "#{bin}/vlmcsd", "-V"
    system "#{bin}/vlmcs", "-V"
    system "vlmcsd", "-V"
    system "vlmcs", "-V"
  end
end
