class Career < ApplicationRecord
  has_and_belongs_to_many :programmes
  has_and_belongs_to_many :soft_skills

  validates :name, presence: true
  validates :average_salary, presence: true, numericality: { only_integer: true }
  # TODO: Remove description, add with responsibilities and add to schema
  validates :responsibilities, presence: true
  validates :summary, presence: true
  validates :progression, presence: true
  validates :education, presence: true
  # TODO: Add progression and education to schema
end
