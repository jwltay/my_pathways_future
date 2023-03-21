class User < ApplicationRecord
  has_and_belongs_to_many :soft_skills
  has_and_belongs_to_many :subjects
  has_many :pathways
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
  end
end
