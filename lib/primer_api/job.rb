module PrimerApi
  class Job
    include ActiveModel::Model

    class << self

        def endpoint
          "/api/schedules"
        end

        def find(id)
          new(Primer.connection.get([endpoint, id].join('/')).to_hash)
        end

    end

    attr_accessor :id, :message_topic, :payload, :schedule

    def schedule=(hash)
      IceCube::Schedule.from_hash(hash)
    end

  end
end
