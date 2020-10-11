class Event < ApplicationRecord
    validates :payload, :guid, :name, presence: true, allow_nil: false
end
