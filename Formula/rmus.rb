class Rmus < Formula
  desc "Keyboard-driven terminal music player"
  homepage "https://github.com/maximilianpw/rmus"
  url "https://github.com/maximilianpw/rmus/archive/2beb94bd5defc558eacad37b3a6df19e96af34d4.tar.gz"
  version "0.1.2"
  sha256 "1d9737d0b05d055655667ec64404dad8a64b08fcdc458e93fb7973522a394d65"
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
  end
end
