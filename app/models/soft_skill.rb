class SoftSkill < ApplicationRecord
  has_and_belongs_to_many :careers
  has_and_belongs_to_many :users
end
