source 'https://rubygems.org'

gem 'rails', '3.2.12'
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails', '2.1.3'
gem 'therubyracer'
gem 'pg'
gem 'haml-rails'
gem 'haml'

gem 'thin', '>= 1.5.0'
gem 'omniauth', '>= 1.1.1'
gem 'omniauth-google-oauth2'
gem 'simple_form', '>= 2.0.4'
gem 'figaro', '>= 0.5.3'
gem 'quiet_assets', '>= 1.0.1', :group => :development
gem 'better_errors', '>= 0.3.2', :group => :development
gem 'binding_of_caller', '>= 0.6.8', :group => :development
gem 'factory_girl_rails', '>= 4.2.0', :group => [:development, :test]
gem 'dotenv-rails', :groups => [:development, :test, :production]

gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'

group :test do
  gem 'timecop'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'mocha', require: 'mocha/setup'
end

group :development, :test do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-jasmine'
  gem 'libnotify', :require => RUBY_PLATFORM =~ /linux/i ? 'libnotify' : false
  gem 'growl', :require => RUBY_PLATFORM =~ /darwin/i ? 'growl' : false
  gem 'rb-inotify', :require => RUBY_PLATFORM =~ /linux/i ? 'rb-inotify' : false
  gem 'rb-fsevent', :require => RUBY_PLATFORM =~ /darwin/i ? 'rb-fsevent' : false
  gem 'sqlite3'
  gem 'jasminerice', :git => 'https://github.com/bradphelan/jasminerice.git'
  gem 'fuubar'
  gem 'rspec-rails'
end

gem 'ember-rails'

gem 'bootstrap3-wip-rails'
gem 'whitespace'

#group :production do
#  gem 'rails_12factor'
#end
