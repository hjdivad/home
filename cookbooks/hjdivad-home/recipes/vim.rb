include_recipe 'hjdivad-home::homebrew'

execute 'Installing macvim.' do
  user    M_USER
  command "test -e #{M_HOME}/.rvm/bin/rvm && (rvm use system); brew install macvim"
  not_if  "brew list | grep '^macvim$'"
end


ruby_block 'Checking vim has +ruby' do
  block do
    `vim --version | grep -q '+ruby'`
    raise "Vim lacks +ruby." unless $?.success?
  end
end

execute 'Installing vim-config' do
  user    M_USER
  command "git clone git@github.com:hjdivad/vim-config.git ~/.vim"
  not_if  "test -d #{M_HOME}/.vim/.git"
end


execute 'Updating vim-config' do
  user    M_USER
  command [ "cd #{M_HOME}/.vim",
            "git checkout -f master",
            "git pull",
            "git submodule update"
          ].join(" && ")
end

execute 'Linking vimrc' do
  user    M_USER
  command "ln -sf #{M_HOME}/.vim/vimrc #{M_HOME}/.vimrc"
end

execute 'Linking gvimrc' do
  user    M_USER
  command "ln -sf #{M_HOME}/.vim/gvimrc #{M_HOME}/.gvimrc"
end
