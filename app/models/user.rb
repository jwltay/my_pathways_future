class User < ApplicationRecord
  has_many :user_soft_skills
  has_many :soft_skills, through: :user_soft_skills

  has_many :user_subjects
  has_many :subjects, through: :user_subjects

  has_many :pathways, dependent: :destroy
  has_many :programmes, through: :pathways
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def careers
    careers = []
    programmes.each do |programme|
      programme.careers.each do |career|
        careers << career
      end
    end
    careers
  end

  validates :email, presence: true, uniqueness: true
  validates :occupation, inclusion: { in: %w[student fresh\ grad working\ adult] }
end
