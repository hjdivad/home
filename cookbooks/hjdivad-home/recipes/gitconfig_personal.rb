execute "Configuring git user" do
  user M_USER
  command "git config --global user.name 'David J. Hamilton'"
end

execute "Configuring git email" do
  user M_USER
  command "git config --global user.email davidjh@hjdivad.com"
end

execute "Configuring github user" do
  user M_USER
  command "git config --global github.user hjdivad"
end
