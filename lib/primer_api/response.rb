require 'ostruct'

module PrimerApi
  class Response
    extend Forwardable

    def_delegators :struct, :method_missing

    def initialize(response)
      @raw_response = response
    end

    def to_hash
      JSON.parse(@raw_response)
    end

    def struct
      @struct ||= OpenStruct.new(to_hash)
    end

  end
end
