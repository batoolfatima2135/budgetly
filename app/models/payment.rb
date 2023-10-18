class Payment < ApplicationRecord
  validates :name, :amount, presence: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :category
end
