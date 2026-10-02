class Skillguard < Formula
  desc "Security scanner for AI agent skills"
  homepage "https://github.com/heyytars/skillguard"
  url "https://github.com/heyytars/skillguard/releases/download/v2.1.0/skillguard-2.1.0.tgz"
  sha256 "1522159b5ea9cc176f37606bbe61a166a9db4097d184fa0e603d7292d8927a82"
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
