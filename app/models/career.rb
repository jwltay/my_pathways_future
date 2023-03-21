class Career < ApplicationRecord
  has_and_belongs_to_many :programmes
  has_and_belongs_to_many :soft_skills
end
