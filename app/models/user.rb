class User < ApplicationRecord
  validates :name, presence: true
  has_many :categories, foreign_key: 'user_id', dependent: :destroy
  has_many :payments, foreign_key: 'author_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
