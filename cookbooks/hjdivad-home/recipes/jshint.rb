include_recipe 'hjdivad-home::node'

execute "Installing jshint" do
  user    M_USER
  command "npm install -g jshint"
  not_if  "npm ls -g jshint | grep -q jshint"
end
