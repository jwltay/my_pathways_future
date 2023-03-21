class Career < ApplicationRecord
  has_many :career_soft_skills
  has_many :soft_skills, through: :career_soft_skills

  validates :name, presence: true
  validates :average_salary, presence: true, numericality: { only_integer: true }
  validates :responsibilities, presence: true
  validates :summary, presence: true
  validates :progression, presence: true
  validates :education, presence: true
end
