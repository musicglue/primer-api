module PrimerApi
  class RecurringJob < Job
    include ActiveModel::Model

    class << self

      def create(schedule, topic, payload)
        job = new({schedule: schedule, topic: topic, payload: payload})
        job.valid? ? job.save : job.errors
      end

    end

  end
end
