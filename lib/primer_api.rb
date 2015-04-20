require 'active_resource'
require 'api_auth'
require 'ice_cube'
require 'primer_api/version'
require 'primer_api/railtie' if defined?(Rails)

module PrimerApi
  module_function

  def api_url
    "#{PrimerApi.config.host.chomp('/')}/api"
  end

  def config
    @config ||= ActiveSupport::OrderedOptions.new.tap do |x|
      x.host = 'https://primer.musicglue.com'
      x.api_key = nil
      x.api_secret = nil
    end
  end

  def configure(&_block)
    yield config
    require 'primer_api/primer_resource'
    require 'primer_api/job'
    config
  end
end
