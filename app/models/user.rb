class User < ApplicationRecord
  has_many :user_soft_skills
  has_many :soft_skills, through: :user_soft_skills

  has_many :user_subjects
  has_many :subjects, through: :user_subjects

  has_many :pathways, dependent: :destroy
  has_many :programmes, through: :pathways, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true

  # CATEGORIES = ["student", "fresh graduate", "working professional"]

  CATEGORIES = [
    "I am a student considering prospective careers",
    "I am a graduate entering the workforce",
    "I am a working professional exploring my options"
  ]

  def careers
    careers = []
    programmes.each do |programme|
      programme.careers.each do |career|
        careers << career
      end
    end
    careers.uniq
  end

  def find_matching_programmes
    scores = {}

    Programme.all.each do |programme|
      score = 0
      programme.subjects.each do |subject|
        subjects.include?(subject) ? score += 2 : score -= 1
      end
      scores[programme] = score
    end
    scores.sort_by { |_, value| value }.reverse.to_h.keys
  end

  def find_matching_careers
    careers = []
    find_matching_programmes.each do |programme|
      careers << programme.careers
    end
    careers.flatten.uniq
  end
end
