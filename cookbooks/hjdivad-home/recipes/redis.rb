execute "Installing redis" do
  user    M_USER
  command "brew install redis"
  not_if  "brew list | grep -q redis"
end

