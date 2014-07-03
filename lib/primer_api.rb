require 'active_support'
require 'active_support/core_ext'
require 'rest_client'

require 'primer_api/response'
require 'primer_api/client'
require 'primer_api/job'
require 'primer_api/recurring_job'
require 'primer_api/single_job'
require 'primer_api/version'

module PrimerApi

  module_function

  def config
    ActiveSupport::OrderedOptions.new.tap do |x|
      x.host = 'http://localhost:3000'
      x.api_key = '3858797C'
      x.api_secret = 'zoLfecqHegvj0RJeEfcRJMAGoSq1PPpoSJqUGJh3/uy5EKlNdEIKtqehD0pYBGET4cl7eZle+HJUgOBVryuzcg=='
    end
  end

  def configure(&block)
    yield(config) if block_given?
  end

  def connection
    @connection ||= PrimerApi::Client.new(config.api_key, config.api_secret, host: config.host)
  end

end
