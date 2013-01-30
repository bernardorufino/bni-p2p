source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'jquery-rails'
gem 'rails-i18n'
gem 'simple_form', '>= 2.0.4'
gem 'bcrypt-ruby', '>= 3.0'
gem 'bootstrap-sass', '~> 2.2.2.0'
gem 'devise', '~> 2.2'
gem 'devise-i18n'

group :development, :test do
  gem 'sqlite3'
  
  # rspec-rails and factory_girl_rails needs to be in development
  # group also so that Rails generators work
  gem 'rspec-rails', '>= 2.0'
  gem 'factory_girl_rails', '~> 4.1'
  
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  
  # If you want full featured Guard, also uncomment your system 
  # dependent gems in test group
  # Check https://github.com/guard/guard for installation
  # Run 'guard init rspec' and edit Guardfile
  # gem 'guard-rspec'
  
end

group :test do 
  gem 'shoulda-matchers', '>= 1.4.2'
  gem 'capybara', '>= 2.0'
  
  # Guard on MAC OSX
  # gem 'rb-fsevent', require: true
  # gem 'growl'
  
  # Guard on Linux
  # gem 'rb-inotify'
  # gem 'libnotify'
  
  # Guard on Windows
  # gem 'rb-notifu'
  # gem 'win32console'
  #
  # gem 'rb-fchange'
  # OR
  # gem 'wdm'
  
end

group :production do
  gem 'pg', '~> 0.14.1'
  
end

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.3.0'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'