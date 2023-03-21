class Pathway < ApplicationRecord
  belongs_to :user
  belongs_to :programme

  def active?
    active == true
  end
end
