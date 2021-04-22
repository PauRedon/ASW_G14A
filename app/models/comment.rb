class Comment < ApplicationRecord
    belongs_to :contribucio
    belongs_to :user
    #belongs_to :comment, class_name: "Comment"
    #has_many :replies, class_name: "Comment"
    
end
