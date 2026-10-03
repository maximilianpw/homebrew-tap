class Loggle < Formula
  desc "A terminal log viewer for local, newline-delimited logs."
  homepage "https://github.com/maximilianpw/loggle"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.2.0/loggle-aarch64-apple-darwin.tar.xz"
      sha256 "a7caa9634b90f2c84f55b081bec46d496546223611978ea0085a33957e47fe32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.2.0/loggle-x86_64-apple-darwin.tar.xz"
      sha256 "c143b37adba03f3748b6666de9d6ae873b775751f7c5902afe36feafade57a91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.2.0/loggle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e89e5202634fe99e242b5cec64766b0d9ef161db14759ff4f06a75afcd5be263"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.2.0/loggle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb4b51822a4915c87e8a0156113002adde3bca832e2f2ed8fed1b6638a396fa8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "loggle"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "loggle"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "loggle"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "loggle"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
