require 'digest'
require 'uri'

module PrimerApi
  class Client
    class MissingApiKeysError < StandardError; end

    def initialize(api_key, api_secret, options={})
      @api_key = api_key
      @api_secret = api_secret
      raise MissingApiKeysError if api_key.nil? || api_secret.nil?
      @options = { host: PrimerApi.config.host }.merge(options)
    end

    def get(path)
      request(path, nil, :get)
    end

    def delete(path)
      request(path, nil, :delete)
    end

    def put(path, payload)
      request(path, payload, :put)
    end

    def post(path, payload)
      request(path, payload, :post)
    end

    private

      def endpoint
        @endpoint ||= URI.parse(@options[:host])
      end

      def request(path, payload, method)
        request = RestClient::Request.new(
          url: build_url(path),
          method: method,
          payload: payload.to_json,
          headers: build_headers(payload),
          ssl_version: 'TLSv1')

        PrimerApi::Response.new(ApiAuth.sign!(request, @api_key, @api_secret).execute)
      end

      def build_headers(payload)
        {
          'Content-MD5' => Digest::MD5.hexdigest(payload.to_json),
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'Date' => Time.now
        }
      end

      def build_url(path)
        uri_builder.build(host: endpoint.host, port: endpoint.port, path: path).to_s
      end

      def uri_builder
        "URI::#{endpoint.scheme.upcase}".constantize
      end

  end
end
