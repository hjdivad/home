
execute "Monday is the first day of the week" do
  user M_USER
  command "
    defaults write ~/Library/Preferences/.GlobalPreferences.plist 
      AppleFirstWeekday -dict gregorian 2
  ".gsub "\n", ' '
end

execute "Dates are formatted DMY" do
  user M_USER
  command "
    defaults write ~/Library/Preferences/.GlobalPreferences.plist 
      AppleICUDateFormatStrings -dict 2 'd MMM, y' 3 'D MMMM, y' 4 'EEEE, d MMMM, y'
  ".gsub "\n", ' '
end
