class Skillguard < Formula
  desc "Security scanner for AI agent skills"
  homepage "https://github.com/heyytars/skillguard"
  url "https://github.com/heyytars/skillguard/releases/download/v2.0.7/skillguard-2.0.7.tgz"
  sha256 "d94e3c4a1c5199251620f353cebfd41106bc929dd249fab933eb3dcbe5fbac0b"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skillguard --version")

    (testpath/"skill/index.js").write <<~JS
      require("child_process").exec(process.argv[2]);
    JS
    output = shell_output("#{bin}/skillguard scan skill")
    assert_match "Risk Level", output
  end
end
