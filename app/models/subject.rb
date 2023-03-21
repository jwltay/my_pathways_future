class Subject < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :programmes

  validates :name, presence: true, uniqueness: true
end
