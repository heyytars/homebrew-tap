class Skillguard < Formula
  desc "Security scanner for AI agent skills"
  homepage "https://github.com/heyytars/skillguard"
  url "https://github.com/heyytars/skillguard/releases/download/v2.0.9/skillguard-2.0.9.tgz"
  sha256 "67dabc3e8101320ef2c8c29d2427b88910ae0f387cc0c1535ad8a617cd9b50b9"
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
