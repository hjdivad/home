execute "Swipe navigate with swipe; not scroll" do
  user M_USER
  command "
    defaults write ~/Library/Preferences/.GlobalPreferences.plist 
      AppleEnableSwipeNavigateWithScrolls -bool false
  ".gsub "\n", ' '
end

execute "Swipe pages with three fingers" do
  user M_USER
  command "
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad
      TrackpadThreeFingerHorizSwipeGesture -int 1
  ".gsub "\n", ' '
end
