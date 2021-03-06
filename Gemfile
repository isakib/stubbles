source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'cancan'
gem 'devise', '~> 2.2.3'
gem 'figaro'
gem 'pg'
gem 'rolify'
gem 'sendgrid'
gem 'workflow'
gem 'acts-as-taggable-on', '~> 2.2.2'
gem "bootstrap-wysihtml5-rails", "~> 0.3.1.23"
gem 'simple_form'
gem 'awesome_print'
gem 'nested_form'
gem 'google_visualr', '~> 2.1.9'

group :assets do
  gem 'therubyracer', :platform => :ruby
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms => [:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'letter_opener' #to test email in development env. Usually stored in tmp/letter_opener
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'rack-mini-profiler'
  gem 'bullet'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end

group :production do
  gem 'memcachier'
  gem 'dalli', '~>1.0.5'
end

gem "cache_digests"
gem 'unicorn'
gem 'less-rails-bootstrap'
gem 'auditlog'
#gem 'auditlog', :path => '/home/jitu/projects/auditlog'