class Contribucio < ApplicationRecord
  validates :tittle, length: {minimum: 4}, presence: true
  belongs_to :user
  
    def author_id
      self.user_id
    end
  
end
