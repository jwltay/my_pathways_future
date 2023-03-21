class UserSoftSkill < ApplicationRecord
  belongs_to :user
  belongs_to :soft_skill
end
