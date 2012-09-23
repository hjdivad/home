
execute "Bottom right hot-corner locks screen" do
  user M_USER
  command "defaults write com.apple.dock wvous-br-corner -int 5"
  command "defaults write com.apple.dock wvous-br-modifier -int 0"
end
