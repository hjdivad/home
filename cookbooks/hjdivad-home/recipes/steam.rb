dmg_package "Steam" do
  volumes_dir "Steam"
  dmg_name "steam"
  source "http://media.steampowered.com/client/installer/steam.dmg"
  checksum "04640d3f481c74b907835fc3d07b89bc31577d63"
  accept_eula true
  action :install
end

steam_dir = "#{M_HOME}/Library/Application Support/Steam" 

directory steam_dir do
  action :create
  recursive true
  owner M_USER
end

directory "#{steam_dir}/config" do
  action :create
  recursive true
  owner M_USER
end

template "#{steam_dir}/config/config.vdf" do
  source "steam_config.vdf.erb"
  owner M_USER
end

template "#{steam_dir}/config/SteamAppData.vdf" do
  source "steam_app_data.vdf.erb"
  owner M_USER
end
