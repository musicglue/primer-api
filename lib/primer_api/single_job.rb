module PrimerApi
  class SingleJob < Job
    include ActiveModel::Model

    class << self

      def endpoint
        "/api/schedules/single"
      end

      def find(id)
        new(PrimerApi.connection.get([endpoint, id].join('/')).to_hash.except('schedule'))
      end

    end

    attr_accessor :next_occurrence

    def attributes
      super.merge({
        next_occurrence: next_occurrence
      })
    end

  end
end
