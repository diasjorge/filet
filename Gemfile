source "http://rubygems.org"

# Specify your gem's dependencies in filet.gemspec
gemspec

gem 'rake'

unless ENV["TRAVIS"]
  gem 'ruby-debug19', :platforms => :ruby_19
  gem 'ruby-debug', :platforms => :mri_18
end
