module PrimerApi
  class PrimerResource < ActiveResource::Base
    self.site = PrimerApi.api_url
    with_api_auth PrimerApi.config.api_key, PrimerApi.config.api_secret
    headers['Accept'] = 'application/vnd.music-glue-primer-app-v2+json'

    class Hash < ::Hash
      def initialize(hash, _persisted)
        merge!(hash)
      end
    end

    def self.hash_attributes *names
      [names].flatten.each do |name|
        create_reflection "#{name}_macro".to_sym, name.to_sym, class_name: 'PrimerApi::PrimerResource::Hash'
      end
    end
  end
end
