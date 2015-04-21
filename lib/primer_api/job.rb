module PrimerApi
  class Job < PrimerResource
    hash_attributes :message_headers, :message_body, :schedule

    validates :message_topic, presence: true

    validate :ice_cube_schedule_must_be_present
    validate :message_body_must_be_a_hash
    validate :message_headers_must_be_a_hash

    before_validation do
      self.schedule = schedule.to_hash if schedule
    end

    private

    def attribute_present? attribute
      respond_to?(attribute) && send(attribute)
    end

    def ice_cube_hash? hash
      hash.respond_to?(:keys) && hash.keys.include?('start_time')
    end

    def ice_cube_schedule_must_be_present
      unless attribute_present? :schedule
        errors.add :schedule, 'must be present'
        return
      end

      return if ice_cube_hash?(schedule)

      errors.add(:schedule, 'must be a Hash representation of an ice_cube schedule')
    end

    def message_body_must_be_a_hash
      optional_attribute_must_be_a_hash :message_body
    end

    def message_headers_must_be_a_hash
      optional_attribute_must_be_a_hash :message_headers
    end

    def optional_attribute_must_be_a_hash attribute
      return unless attribute_present? attribute
      return if send(attribute).class.in? [Hash, ActiveSupport::HashWithIndifferentAccess]

      errors.add(attribute, 'must be a Hash, if supplied')
    end
  end
end
