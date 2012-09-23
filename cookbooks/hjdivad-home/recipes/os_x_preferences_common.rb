include_recipe 'hjdivad-home::os_x_preferences_screensaver'
include_recipe 'hjdivad-home::os_x_preferences_fast_key_repeat'
include_recipe 'hjdivad-home::os_x_preferences_multitouch'

execute "Don't show dashboard in spaces" do
  user M_USER
  command "defaults write com.apple.dock dashboard-in-overlay -bool true"
end
