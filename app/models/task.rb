class Task < ApplicationRecord
  belongs_to :user
  scope :completed, -> { where(completed: true) }
end
