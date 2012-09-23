
execute "Install tmux via homebrew" do
  user M_USER
  command "brew install tmux"
  not_if "brew list | grep -q tmux"
end
