# frozen_string_literal: true

class Kcptun < Formula
  desc 'A Stable & Secure Tunnel Based On KCP with N:M Multiplexing'
  homepage 'https://github.com/xtaci/kcptun'
  version 'v20191127'
  url "https://github.com/xtaci/kcptun/archive/#{version}.tar.gz"
  sha256 '35375d7633871f954d2a3a1a34704a0a27a7e55ac75102f22ead545cfa2565da'

  depends_on 'go' => :build

  def install
    # ENV["GO111MODULE"] = "on"
    ENV['GOPROXY'] = 'https://goproxy.io'
    system 'go', 'build', '-o', 'bin/kcptunc', './client'
    system 'go', 'build', '-o', 'bin/kcptuns', './server'

    bin.install 'bin/kcptunc'
    bin.install 'bin/kcptuns'
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.ap
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/kcptun-client</string>
          <string>-c</string>
          <string>#{etc}/kcptun/config.json</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>#{var}/log/kcptun-client-error.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/kcptun-client.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    client_version = shell_output("#{bin}/kcptunc -v")
    assert_match 'kcptun version SELFBUILD', client_version
    server_version = shell_output("#{bin}/kcptuns -v")
    assert_match 'kcptun version SELFBUILD', server_version
    system 'kcptunc', '-v'
    system 'kcptuns', '-v'
  end
end
