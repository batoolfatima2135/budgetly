class Payment < ApplicationRecord
  
  belongs_to :author
  belongs_to :category
end
