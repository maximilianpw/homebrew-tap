class Rmus < Formula
  desc "Keyboard-driven terminal music player"
  homepage "https://github.com/maximilianpw/rmus"
  url "https://github.com/maximilianpw/rmus/archive/193a2132eaba97c9eee2295a87d5e5bedc64e009.tar.gz"
  version "0.1.2"
  sha256 "28be11a5e0279d08a4ce41f2230bf668ef411fb29386537c0a28553261abd17b"
  license "MIT"
  head "https://github.com/maximilianpw/rmus.git", branch: "main"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "mpv"
  depends_on "openssl@3"

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"rmus", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rmus --version")
    assert_match "complete -c rmus", shell_output("#{bin}/rmus completions fish")
    paths_output = shell_output("#{bin}/rmus paths")
    assert_match "config:", paths_output
    assert_match "local cache:", paths_output
    assert_match "rmus status", shell_output("#{bin}/rmus status")
    assert_match "Streaming accounts already absent", shell_output("#{bin}/rmus clear-accounts")
  end
end
