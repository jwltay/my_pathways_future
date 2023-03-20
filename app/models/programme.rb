class Programme < ApplicationRecord
  has_and_belongs_to_many :careers
  has_and_belongs_to_many :subjects

  has_many :pathways
  has_many :users, through: :pathways
end
