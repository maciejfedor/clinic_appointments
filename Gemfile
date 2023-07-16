source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Base
gem "importmap-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

# Assets
gem "sass-rails"
gem "tailwindcss-rails"

# Views
gem "flatpickr", "~> 4.6", ">= 4.6.11.0"
gem "inline_svg", "~> 1.9"
gem "view_component", "~> 3.3"

# Filtering data
gem "counter_culture", "~> 3.4"
gem "groupdate", "~> 2.5", ">= 2.5.2"
gem "pagy", "~> 6.0", ">= 6.0.4"
gem "ransack", "~> 4.0"

# Other
gem "bootsnap", require: false
gem "name_of_person", "~> 1.1", ">= 1.1.1"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "annotate", "~> 3.2"
  gem "better_errors", "~> 2.10", ">= 2.10.1"
  gem "brakeman", "~> 6.0"
  gem "bullet", "~> 7.0", ">= 7.0.7"
  gem "bundler-audit", "~> 0.9.1", require: false
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", "~> 1.54", require: false
end

group :development do
  gem "actioncable", "~> 7.0", ">= 7.0.6"
  gem "listen", "~> 3.8"
  gem "lookbook", "~> 2.0", ">= 2.0.5"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
