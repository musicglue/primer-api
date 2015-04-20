ENV['RAILS_ENV'] ||= 'test'

require 'awesome_print'
require 'pry-byebug'
require 'simplecov'
require 'minitest/spec'
require 'minitest/reporters'
require 'minitest/autorun'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)
SimpleCov.start

require_relative '../lib/primer_api'

PrimerApi.configure do |config|
  config.host = 'http://localhost:3000'
end
