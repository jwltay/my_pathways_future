class Subject < ApplicationRecord
  has_many :user_subjects
  has_many :users, through: :user_subjects

  has_many :programme_subjects
  has_many :programmes, through: :programme_subjects

  validates :name, presence: true, uniqueness: true
end
