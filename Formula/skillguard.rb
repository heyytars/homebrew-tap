class Skillguard < Formula
  desc "Security scanner for AI agent skills"
  homepage "https://github.com/heyytars/skillguard"
  url "https://github.com/heyytars/skillguard/releases/download/v2.4.0/skillguard-2.4.0.tgz"
  sha256 "cc32aff595fc37c2efcb9da6035fcedfb4cd64272c9893d843294d65e8605af3"
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
