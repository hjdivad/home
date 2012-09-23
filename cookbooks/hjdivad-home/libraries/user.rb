raise "Must run as sudo." unless ENV.has_key? 'SUDO_USER'

M_USER=ENV['SUDO_USER'].strip
M_HOME=ENV['HOME'].strip

raise "Don't run as root directly" if M_USER == 'root'
