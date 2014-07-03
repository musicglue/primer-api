module PrimerApi
  class RecurringJob < Job
    include ActiveModel::Model

    class UnsupportedScheduleError < StandardError; end

    class << self

      def endpoint
        "/api/schedules/recurring"
      end

      def find(id)
        new(PrimerApi.connection.get([endpoint, id].join('/')).to_hash.except('next_occurrence'))
      end

    end

    attr_accessor :schedule

    validates :schedule, presence: true

    def schedule=(value)
      case value
      when Hash
        @schedule = IceCube::Schedule.from_hash(value.except('start_date'))
      when IceCube::Schedule
        @schedule = value
      else
        raise UnsupportedScheduleError unless value.nil?
      end
    end

    def attributes
      super.merge({
        schedule: schedule.to_hash
      })
    end

  end
end
