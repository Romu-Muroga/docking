source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# default
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# has_secure_password
gem 'bcrypt', '~> 3.1.11'
# file upload
gem 'carrierwave'
# iine count
gem 'counter_culture', '~> 1.8'
# seed data
gem 'faker'
# autocomplete
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'
# image resize
gem 'mini_magick', '>= 4.9.4'
# search
gem 'ransack'
# auto_link
gem 'rails_autolink'
# pagination
gem 'kaminari'

group :development, :test do
  # debug
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
  # ENV
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Rspec
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'spring-commands-rspec'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
