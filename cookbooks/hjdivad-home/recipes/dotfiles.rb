include_recipe 'hjdivad-home::github'

execute "Updating dotfiles." do
  user    M_USER
  command "cd #{M_HOME}/.dotfiles && git pull"
  not_if  "test ! -d #{M_HOME}/.dotfiles"
end

execute "Cloning dotfiles." do
  user    M_USER
  command "cd #{M_HOME} && git clone git@github.com:hjdivad/dotfiles .dotfiles"
  not_if "test -d #{M_HOME}/.dotfiles"
end

ruby_block "Installing dotfiles" do
  block do
    Bundler.with_clean_env do
      system %Q{sudo -u #{M_USER} cd #{M_HOME}/.dotfiles && rake install}
    end
  end
end

