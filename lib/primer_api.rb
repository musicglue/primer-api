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

    # Primer's api is expecting a root 'job' element
    # in the request body. If this is not set, things
    # like unique_key won't be added to the job in Primer,
    # leading to Bad Things.
    ActiveResource::Base.include_root_in_json = true

    require 'primer_api/primer_resource'
    require 'primer_api/job'
    config
  end
end
