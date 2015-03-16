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
        topic_name = message.to_topic_name if message.respond_to?(:to_topic_name)
        topic_name = message.topic_name if message.respond_to?(:topic_name)

        fail 'Topic name not found.' if topic_name.blank?

        new(
          next_occurrence: next_occurrence,
          message_topic: topic_name,
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
