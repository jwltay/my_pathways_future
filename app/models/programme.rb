class Programme < ApplicationRecord
  has_and_belongs_to_many :careers
  has_and_belongs_to_many :subjects

  has_many :pathways
  has_many :users, through: :pathways

  validates :tuition_fees, numericality: true, presence: true
  validates :duration, numericality: true, presence: true
  validates :rating, numericality: true, presence: true
  validates :description, presence: true
end
