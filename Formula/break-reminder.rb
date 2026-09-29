class BreakReminder < Formula
  desc "Blur-overlay break reminder for macOS with a menu bar countdown"
  homepage "https://github.com/svensoldin/break-reminder"
  url "https://github.com/svensoldin/break-reminder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a779a4fee5402f164e1ed8bd2cf37bc6f2b6ea541afe6d37e82be3380f16c779"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "break-reminder", "BreakReminder.swift"
    system "swiftc", "-O", "-o", "break-reminder-menu", "BreakReminderMenu.swift"
    bin.install "break-reminder", "break-reminder-menu"
  end

  service do
    run opt_bin/"break-reminder-menu"
    # Restart after a crash, but let Quit from the menu stick.
    keep_alive successful_exit: false
  end

  def caveats
    <<~EOS
      Start the menu bar app now and at every login:
        brew services start break-reminder

      If you installed with ./install.sh before, run ./uninstall.sh from that
      clone first so two schedulers don't run at once.
    EOS
  end

  test do
    assert_predicate bin/"break-reminder", :executable?
    assert_predicate bin/"break-reminder-menu", :executable?
  end
end
