class SoftSkill < ApplicationRecord
  has_many :user_soft_skills
  has_many :users, through: :user_soft_skills

  has_many :career_soft_skills
  has_many :career, through: :career_soft_skills

  validates :name, presence: true, uniqueness: true
end
