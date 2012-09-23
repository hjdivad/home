execute "Installing node" do
  user    M_USER
  command "brew install node"
  not_if  "brew list | grep -q node"
end
