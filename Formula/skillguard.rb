class Skillguard < Formula
  desc "Security scanner for AI agent skills"
  homepage "https://github.com/heyytars/skillguard"
  url "https://github.com/heyytars/skillguard/releases/download/v2.2.0/skillguard-2.2.0.tgz"
  sha256 "e43f73d444a10d49a989cd2b49eaa722b877f1df3a615cf2c6affbbdec43c6d9"
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
