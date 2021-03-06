require 'formula'

class BrewAutoUpdate < Formula
  depends_on 'terminal-notifier'

  homepage 'https://github.com/jsok/homebrew-auto-update/'
  head 'https://github.com/jsok/homebrew-auto-update.git', :branch => 'master'

  def install
    inreplace 'bin/brew-auto-update', '/usr/local', HOMEBREW_PREFIX
    prefix.install 'bin'
    (bin/'brew-auto-update').chmod 0755
  end

  plist_options startup: false

  def plist; <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC -//Apple Computer//DTD PLIST 1.0//EN http://www.apple.com/DTDs/PropertyList-1.0.dtd >

<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>#{plist_name}</string>

    <key>ProgramArguments</key>
    <array>
      <string>#{opt_bin}/brew-auto-update</string>
    </array>

    <key>ProcessType</key>
    <string>Background</string>

    <key>StartCalendarInterval</key>
    <dict>
      <!-- 7:00am each day -->
      <key>Hour</key>
      <integer>7</integer>
      <key>Minute</key>
      <integer>0</integer>
    </dict>

    <key>RunAtLoad</key>
    <true/>

    <key>StandardOutPath</key>
    <string>~/Library/Logs/brew-auto-update/update.log</string>

    <key>StandardErrorPath</key>
    <string>~/Library/Logs/brew-auto-update/update.log</string>
  </dict>
</plist>
EOS
  end
end
