class Pathway < ApplicationRecord
  belongs_to :user
  belongs_to :programme

  validates :user, presence: true
  validates :programme, presence: true
end
