class Category < ApplicationRecord
  validates :name, :icon, presence: true
  belongs_to :user
  has_many :payments, dependent: :destroy
  has_one_attached :icon
end
