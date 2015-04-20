source 'https://rubygems.org'

gemspec

group :development do
  gem 'guard'
  gem 'guard-minitest', require: false
  gem 'guard-rubocop', github: 'musicglue/guard-rubocop', require: false
  gem 'rubocop'
end

group :development, :test do
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'rake'
end

group :test do
  gem 'minitest'
  gem 'minitest-focus'
  gem 'minitest-reporters'
  gem 'simplecov', require: false
end
