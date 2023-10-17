class User < ApplicationRecord
  validates :name,  presence: true
  has_many :categories, foreign_key: "user_id"
  has_many :payments, foreign_key: "author_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
