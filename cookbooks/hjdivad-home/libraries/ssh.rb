Object.class_eval do
  def ssh_pubkeys
    Dir["#{M_HOME}/.ssh/*.pub"].map do |pubfile|
      File.read( pubfile )[/(ssh-\w+ \S+)/]
    end
  end
end
