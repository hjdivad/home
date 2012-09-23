# encoding: utf-8

include_recipe 'hjdivad-home::ssh'

run_unless_marker_file_exists 'github/ssh_key' do
  ruby_block "Adding ssh key to github" do
    block do
      key = ssh_pubkeys.first
      github_add_key key: key
    end

    not_if do
      ! (github_keys & ssh_pubkeys).empty?
    end
  end
end
