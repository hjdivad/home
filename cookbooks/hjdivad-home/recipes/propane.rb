app_path="/Applications/Propane.app"

unless File.exists?(app_path)

  remote_file "#{Chef::Config[:file_cache_path]}/propane.zip" do
    source "http://propaneapp.com/appcast/Propane.zip"
    owner M_USER
  end

  execute "unzip propane" do
    command "unzip #{Chef::Config[:file_cache_path]}/propane.zip -d #{Chef::Config[:file_cache_path]}/"
  end

  execute "change propane ownership" do
    command "chown -R #{M_USER}:admin #{Chef::Config[:file_cache_path]}/Propane.app"
  end

  execute "copy propane to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Propane.app #{Regexp.escape(app_path)}"
  end

  ruby_block "test to see if Propane.app was installed" do
    block do
      raise "Propane.app was not installed" unless File.exists?(app_path)
    end
  end

end
