class Programme < ApplicationRecord
  has_many :pathways
  has_many :users, through: :pathways

  has_many :events

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

  # Check if programme has been shortlisted by the current user
  # -----------------------------------------------
  # checks pathways where the user is the current user
  # and returns the opposite of whether the resultant set
  # is empty of not
  def shortlisted?(user)
    !pathways.where(user:).empty?
  end

  def shortlisted_pathway(user)
    Pathway.where(user: user, programme: self).first
  end
end
