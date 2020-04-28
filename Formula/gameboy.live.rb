# frozen_string_literal: true

class GameboyLive < Formula
  desc 'A basic gameboy emulator with terminal "Cloud Gaming" support'
  homepage 'https://github.com/HFO4/gameboy.live'
  version '0.1'
  url "https://github.com/HFO4/gameboy.live/archive/#{version}.tar.gz"
  sha256 '2923467649b188ebd02c8994fa5e49a2264f0a27fdbb56539140ae521d96b2fc'

  depends_on 'go' => :build

  def install
    ENV['GO111MODULE'] = 'auto'
    ENV['GOPROXY'] = 'https://goproxy.io'
    system 'go', 'build', '-o', 'gbdotlive', 'main.go'

    bin.install 'gbdotlive'
  end

  test do
    system 'gbdotlive' \
             '-h'
  end
end
