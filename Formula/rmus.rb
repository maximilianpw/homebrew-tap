class Rmus < Formula
  desc "Keyboard-driven terminal music player"
  homepage "https://github.com/maximilianpw/rmus"
  url "https://github.com/maximilianpw/rmus/archive/4c9be1b753cb36d3fecae80d14982c66489ebcdb.tar.gz"
  version "0.1.2"
  sha256 "b18197e1806db09872ad49d807003a038c09507ab2b0f38a0569ed225a20cf8b"
  license "MIT"
  head "https://github.com/maximilianpw/rmus.git", branch: "main"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "mpv"
  depends_on "openssl@3"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rmus --version")
    paths_output = shell_output("#{bin}/rmus paths")
    assert_match "config:", paths_output
    assert_match "local cache:", paths_output
  end
end
