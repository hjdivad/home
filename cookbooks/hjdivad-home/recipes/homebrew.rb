
ruby_block 'Checking homebrew.' do
  block do
    `brew --version`
    raise "Couldn't find brew." unless $?.success?
  end
end
