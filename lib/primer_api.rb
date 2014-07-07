require 'active_support'
require 'active_support/core_ext'
require 'api_auth'
require 'rest_client'

require 'primer_api/response'
require 'primer_api/client'
require 'primer_api/job'
require 'primer_api/recurring_job'
require 'primer_api/single_job'
require 'primer_api/version'

require 'primer_api/railtie' if defined?(Rails)

module PrimerApi
  ROOT_PATH = File.dirname(File.dirname(__FILE__))

  module_function

  def config
    @config ||= ActiveSupport::OrderedOptions.new.tap do |x|
      x.host        = 'https://primer.musicglue.com'
      x.api_key     = nil
      x.api_secret  = nil
    end
  end

  def env
    (ENV['RACK_ENV'] || ENV['RAILS_ENV'] || ENV['PRIMER_ENV'] || 'development').inquiry
  end

  def configure(&block)
    yield(config) if block_given?
  end

  def connection
    @connection ||= PrimerApi::Client.new(config.api_key, config.api_secret, host: config.host)
  end

end
