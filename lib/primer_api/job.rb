module PrimerApi
  class Job
    include ActiveModel::Model

    class << self

        def endpoint
          raise NotImplementedError
        end

        def find(id)
          raise NotImplementedError
        end

        def create(attrs)
          new(attrs).save
        end

    end

    attr_accessor :id, :message_topic, :payload

    def persisted?
      !!id
    end

    def attributes
      {
        id: id,
        message_topic: message_topic,
        payload: payload
      }
    end

    def destroy
      PrimerApi.connection.delete([self.class.endpoint, id].join('/'))
    end

    def save
      request = if persisted?
        PrimerApi.connection.put([self.class.endpoint, id].join('/'), attributes)
      else
        PrimerApi.connection.post(self.class.endpoint, attributes)
      end
      assign_attributes(request.to_hash)
      self
    end

    def assign_attributes(values)
      attributes.keys.each do |key|
        send("#{key}=", values[key.to_s]) if values[key.to_s]
      end
    end

  end
end
