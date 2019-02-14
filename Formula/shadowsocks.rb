class Shadowsocks < Formula
  include Language::Python::Virtualenv

  desc "A fast tunnel proxy that helps you bypass firewalls."
  homepage "https://github.com/shadowsocks/shadowsocks"
  version "2.8.2"
  url "https://github.com/shadowsocks-backup/shadowsocks/archive/#{version}.tar.gz"
  sha256 "31522454743aa870f6fc75ebfd6ebe28489e491c9a8cb05e805bde1f14b881ae"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "ssserver -h"
    system "sslocal -h"
  end
end
