class Comment < ApplicationRecord
    belongs_to :contribucio, optional: true
    belongs_to :user
    belongs_to :parent, class_name: "Comment", optional: true
    has_many :replies, class_name: "Comment", foreign_key: "parent_id"
    has_many :vote_comments
    
    def parent
        self.parent
    end

end
