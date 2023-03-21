class Programme < ApplicationRecord
  has_and_belongs_to_many :careers
  has_and_belongs_to_many :subjects

  has_many :pathways
  has_many :users, through: :pathways

  has_many :programme_subjects
  has_many :subjects, through: :programme_subjects

  has_many :career_programmes
  has_many :careers, through: :career_programmes

  validates :tuition_fees, numericality: true, presence: true
  validates :duration, numericality: true, presence: true
  validates :rating, numericality: true, presence: true
  validates :summary, presence: true
  validates :name, presence: true
  validates :university, presence: true
  validates :overview, presence: true
end
