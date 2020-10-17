class Event < ApplicationRecord
  scope :issues, -> { where name: 'issues' }
  validates :payload, :guid, :name, presence: true, allow_nil: false
  validate :payload_format

  private
    def payload_format
      if payload.try('[]','sender').nil?
        errors.add(:payload, "JSON must have a sender field")
      end
    end
end
