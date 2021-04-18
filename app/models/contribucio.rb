class Contribucio < ApplicationRecord
  validates :tittle, length: {minimum: 4}, presence: true
  
end
