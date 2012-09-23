Object.class_eval do
  require 'bundler/setup'
  require 'json'
  require 'httparty'

  def github_user
    @github_user ||= (
      print 'Github username: '
      STDIN.gets.chomp
    )
  end

  def github_password
    @github_password ||= (
      system "stty -echo"
      print "Github password for #{github_user}: "
      STDIN.gets.chomp.tap{ system "stty echo" }
    )
  end

  def github_url path
    "https://api.github.com/#{path.gsub %r{^/}, ''}"
  end

  def require_successful_response
    # Weirdly 
    #   HTTParty.get(…).class        #=> HTTParty::Response
    #   HTTParty.get(…).tap{}.class  #=> Array
    response = yield
    unless response.headers['status'] =~ /^2\d\d/
      raise "HTTP error: #{response.parsed_response}"
    end
    response
  end

  def github_get path
    require_successful_response do
      HTTParty.get( github_url( path ), basic_auth: {
        username: github_user,
        password: github_password })
    end.body
  end

  def github_post path, body
    require_successful_response do
      HTTParty.post( github_url( path ),
        basic_auth: {
          username: github_user,
          password: github_password },
        body: body.to_json )
    end.body
  end

  def github path
    JSON.parse github_get path
  end

  def github_keys
    @github_keys ||= github('/user/keys').map{|kinfo| kinfo['key']}
  end

  def github_add_key options={}
    raise ":key is required" unless options.has_key? :key
    title = options[:title] || "#{M_USER}@#{`hostname -s`.chomp}"

    github_post('/user/keys', {
      title:  title,
      key:    options[:key],
    })
  end
end
