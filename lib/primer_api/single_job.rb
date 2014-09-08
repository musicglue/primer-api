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

      def from_message message, next_occurrence, unique_key = nil
        new(
          next_occurrence: next_occurrence, 
          message_topic: message.topic_name,
          payload: message.attributes,
          unique_key: unique_key
        )
      end

    end

    attr_accessor :next_occurrence

    validates :next_occurrence, presence: true

    def attributes
      super.merge({
        next_occurrence: next_occurrence
      })
    end

  end
end
