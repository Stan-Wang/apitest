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

  s.add_runtime_dependency "rails", "~> 5.0"
  s.add_runtime_dependency 'slim-rails', '~> 0'
  s.add_runtime_dependency 'rails-adminlte', '~> 0'
  s.add_runtime_dependency 'vuejs-rails', '~> 0'
  s.add_runtime_dependency "ansi-to-html" ,  '~> 0'
  s.add_runtime_dependency "font-awesome-rails" , '~> 0'
  s.add_runtime_dependency "ionicons-rails" , '~> 0'
  s.add_runtime_dependency "eventmachine" , '~> 0'
  s.add_runtime_dependency "eventmachine-tail" , '~> 0'
  s.add_runtime_dependency "websocket-eventmachine-server" , '~> 0'
 end
