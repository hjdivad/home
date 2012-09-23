
execute "Reasonable delay before key repeat" do
  user M_USER
  command "
    defaults write ~/Library/Preferences/.GlobalPreferences.plist 
      InitialKeyRepeat -int 25
  ".gsub "\n", ' '
end

execute "Reasonable key repeat" do
  user M_USER
  command "
    defaults write ~/Library/Preferences/.GlobalPreferences.plist 
      KeyRepeat -int 2
  ".gsub "\n", ' '
end
