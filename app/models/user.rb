class User < ApplicationRecord
  has_many :user_soft_skills, dependent: :destroy
  has_many :soft_skills, through: :user_soft_skills

  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects

  has_many :pathways, dependent: :destroy
  has_many :programmes, through: :pathways, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true


  CATEGORIES = [
    "I am a student considering prospective careers",
    "I am a graduate entering the workforce",
    "I am a working professional exploring my options"
  ]

  # CATEGORIES = ["Ruby", "JavaScript", "CSS"]

  def generate_pathways
    find_matching_programmes.each do |programme|
      Pathway.create!(user: self, programme:)
    end
  end

  # lists recommended careers for a user
  def careers
    sort_careers_by_skills(find_matching_careers)
  end

  private

  # matches user with programmes by their shared subjects
  def find_matching_programmes
    scores = {}

    Programme.includes(programme_subjects: :subject).all.each do |programme|
      score = 0
      programme.subjects.each do |subject|
        score -= 2 unless subjects.include?(subject)
      end
      scores[programme] = score unless score.negative?
    end
    scores.sort_by { |_, value| value }.reverse.to_h.keys
  end

  # finds careers associated with each of the suggested programmes for a user
  def find_matching_careers
    careers = []

    find_matching_programmes.each do |programme|
      careers << programme.careers
    end
    careers.flatten.uniq!
  end

  # sorts careers by how much their associated soft skills match with the user's
  def sort_careers_by_skills(careers)
    career_by_scores = {}

    careers.each do |career|
      score = 0
      career.soft_skills.each do |soft_skill|
        soft_skills.include?(soft_skill) ? score += 2 : score -= 1
      end
      career_by_scores[career] = score
    end
    career_by_scores.sort_by { |_, value| value }.reverse.to_h.keys
  end
end
