$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "apitest/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "apitest"
  s.version     = Apitest::VERSION
  s.authors     = ["Kyuubi"]
  s.email       = ["kyuubi@chinacluster.com"]
  s.homepage    = "https://github.com/kyuubi9/apitest"
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "slim-rails"
  s.add_dependency "rails-adminlte"
  s.add_dependency "vuejs-rails"
  s.add_dependency "ansi-to-html"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "ionicons-rails"
  s.add_dependency "eventmachine"
  s.add_dependency "lodash-rails"
  s.add_dependency "eventmachine-tail"
  s.add_dependency "websocket-eventmachine-server"
end
