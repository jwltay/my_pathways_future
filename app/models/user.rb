class User < ApplicationRecord
  has_and_belongs_to_many :soft_skills

  has_many :user_subjects
  has_many :subjects, through: :user_subjects

  has_many :pathways, dependent: :destroy
  has_many :programmes, through: :pathways
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :occupation, inclusion: { in: %w[student fresh\ grad working\ adult] }
end
