
ruby_block "Generating ssh key" do
  block do
    system %Q{sudo -u "#{M_USER}" ssh-keygen}
    unless $?.success?
      raise "Error generating ssh key."
    end
  end

  not_if { File.readable? "#{ENV['HOME']}/.ssh/id_rsa.pub" }
end
