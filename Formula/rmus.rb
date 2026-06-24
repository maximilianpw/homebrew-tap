class Rmus < Formula
  desc "Keyboard-driven terminal music player"
  homepage "https://github.com/maximilianpw/rmus"
  url "https://github.com/maximilianpw/rmus/archive/3186cf7f227e73bc7a93a53ab21b129c086ec92b.tar.gz"
  version "0.1.2"
  sha256 "c9ccd240930e0f3bbe9d2312a576835ad8a3329360fbacfe9e89bb8881160b3a"
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
