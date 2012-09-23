fonts_dir = "#{M_HOME}/Library/Fonts"

directory fonts_dir do
  action :create
  recursive true
  owner M_USER
end

remote_file "#{fonts_dir}/Inconsolata.otf" do
  owner M_USER
  source "http://www.levien.com/type/myfonts/Inconsolata.otf"
  mode 0644
end

ruby_block "Update fonts.list" do
  block do
    File.open("#{fonts_dir}/fonts.list", 'a') do |f|
      f.puts "#{fonts_dir}/Inconsolata.otf"
    end
  end
  not_if "grep -q Inconsolata.otf #{fonts_dir}/fonts.list"
end

ruby_block "Update fonts.dir" do
  block do
    File.open("#{fonts_dir}/fonts.dir", 'a') do |f|
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-ascii-0'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso10646-1'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-1'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-15'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-2'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-9'
    end
  end
  not_if "grep -q Inconsolata.otf #{fonts_dir}/fonts.dir"
end

ruby_block "Update fonts.scale" do
  block do
    File.open("#{fonts_dir}/fonts.scale", 'a') do |f|
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-ascii-0'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso10646-1'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-1'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-15'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-2'
      f.puts 'Inconsolata.otf -misc-inconsolata-medium-r-normal--0-0-0-0-p-0-iso8859-9'
    end
  end
  not_if "grep -q Inconsolata.otf #{fonts_dir}/fonts.scale"
end


