class User < ApplicationRecord
  has_and_belongs_to_many :soft_skills
  has_and_belongs_to_many :subjects
  has_many :pathways, dependent: destroy
  has_many :programmes, through: :pathways
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/ }
  validates :current_profession
  # TODO: Remove age and include occupation in schema
  validates :occupation, presence: true, inclusion: { in: %w[student fresh\ grad working\ adult] }
end
