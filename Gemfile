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

gem "thin", ">= 1.5.0"
gem "omniauth", ">= 1.1.1"
gem "omniauth-google-oauth2"
gem "simple_form", ">= 2.0.4"
gem "figaro", ">= 0.5.3"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "better_errors", ">= 0.3.2", :group => :development
gem "binding_of_caller", ">= 0.6.8", :group => :development
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "zeus", :group => [:development, :test]
gem 'dotenv-rails', :groups => [:development, :test, :production]

gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'

group :test do
  gem 'timecop'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'mocha', require: 'mocha/setup'
end
gem 'rspec-rails', :groups => [:development, :test]

group :development, :test do
  gem 'guard'
  gem 'guard-rspec'
  # gem 'guard-jasmine'
  gem 'rb-fsevent', '~> 0.9'
  gem 'rb-inotify'
  gem 'sqlite3'
  # gem "jasminerice", :git => 'https://github.com/bradphelan/jasminerice.git'
  gem 'qunit-rails'
end

gem "ember-rails"

# TODO why not to use SASS version (we usually don't use less)
#gem "bootstrap-sass", ">= 2.2.2.0"
gem 'less-rails'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

gem "whitespace"

group :development, :test do
  gem "jasminerice", :git => 'https://github.com/bradphelan/jasminerice.git'
  gem 'guard-jasmine'
end
