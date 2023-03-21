class Career < ApplicationRecord
  has_and_belongs_to_many :programmes
  has_and_belongs_to_many :soft_skills

  # TODO: Add name to schema
  validates :name, presence
  validates :average_salary, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
end
