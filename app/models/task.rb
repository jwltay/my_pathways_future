class Task < ApplicationRecord
  belongs_to :user

  attribute :completed, default: false
end
