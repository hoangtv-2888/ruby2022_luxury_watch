source "https://rubygems.org"

git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"
gem "active_storage_validations", "0.8.2"
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.4", require: false
gem "chartkick"
gem "cocoon"
gem "config"
gem "faker", "2.1.2"
gem "figaro"
gem "groupdate"
gem "i18n-js"
gem "image_processing"
gem "jbuilder", "~> 2.7"
gem "jquery-rails"
gem "mini_magick"
gem "mysql2", "~> 0.5"
gem "pagy"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4", ">= 6.1.4.4"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "simplecov"
gem "simplecov-rcov"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "shoulda-matchers"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end
