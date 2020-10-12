class Event < ApplicationRecord
  validates :payload, :guid, :name, presence: true, allow_nil: false
  validate :payload_format

  private
    def payload_format
      minimal_keys =  %w(action sender repository)
      payload_hash = JSON.parse(payload || '{}').with_indifferent_access
      minimal_keys.map do |key|
        unless payload_hash.keys.include? key
          errors.add(:payload, "JSON must have the #{key} field")
        end
      end
    end
end
