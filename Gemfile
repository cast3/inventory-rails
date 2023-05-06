source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# rails
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# chartkick requires groupdate
gem 'chartkick'
gem 'groupdate' # used by Chartkick

# delayed
gem 'delayed' # delayed_job_active_record rails 7 fork: https://github.com/betterment/delayed

# devise
gem 'devise'

# figaro
gem 'figaro'

# foreman
gem 'foreman'

# htmlbeautifier
gem 'erb-formatter'
gem 'htmlbeautifier'

# httparty
gem 'httparty'

# importmap
gem 'importmap-rails'

# jbuilder
gem 'jbuilder'

# metamagic
gem 'metamagic' # easily insert metatags for SEO / opengraph

# pg - postgres
gem 'pg', '~> 1.1'

# puma
gem 'puma', '~> 5.6'

# rack-cors - CORS
gem 'rack-cors', require: 'rack/cors'

# rails-i18n - internationalization - translations
gem 'rails-i18n'

# redis
gem 'redis'

# rubocop - linter
gem 'rubocop', require: false

# sprockets - asset pipeline
gem 'sprockets-rails'

# stimulus - javascript framework
gem 'stimulus-rails'

# turbo-rails
gem 'turbo-rails'

# tailwindcss
gem 'tailwindcss-rails'

# img processing
gem 'image_processing'

# caxlsx
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'rubyzip', '~> 2'

# pagy
gem 'net-http'
gem 'pagy'
gem 'pg_search'
gem 'whenever', require: false

# fontawersome
gem 'font-awesome-sass', '~> 6.4.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
end

group :development do
  gem 'letter_opener' # view mailers in browser
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
