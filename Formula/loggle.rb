class Loggle < Formula
  desc "A terminal log viewer for local, newline-delimited logs."
  homepage "https://github.com/maximilianpw/loggle"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.1.3/loggle-aarch64-apple-darwin.tar.xz"
      sha256 "293daa603f670a3476c8888c0988c17d4bfbbf39aaa9bdc26dd6f15c7a07aff6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.1.3/loggle-x86_64-apple-darwin.tar.xz"
      sha256 "87a14b744231bc81726747a048bcde731553f43575a288df7964d4e861892b43"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.1.3/loggle-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "08c1e436985fb18e78d5e9ab623adde0ecac04eadc8e87dfc02d0c07e209f1dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/maximilianpw/loggle/releases/download/v0.1.3/loggle-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "edf33ff7c773ad57e334036fe0eef7576bca51d6d3a0183cfa98f7dc7fe00740"
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
    bin.install "loggle" if OS.mac? && Hardware::CPU.arm?
    bin.install "loggle" if OS.mac? && Hardware::CPU.intel?
    bin.install "loggle" if OS.linux? && Hardware::CPU.arm?
    bin.install "loggle" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
