
# Finder
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder QuitMenuItem -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true

mkdir -p ~/screenshots
defaults write com.apple.screencapture location ~/screenshots/

# Dock
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock show-recents -bool false

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
defaults write NSGlobalDomain AppleLanguages -array "en-GB"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0

# Screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Menu
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.menuextra.clock DateFormat "EEE d MMM  h:mm a"

# Restart everything
for app in "Dock" \
	"SystemUIServer" \
	"Finder"; do
	killall "${app}" &> /dev/null
done
