class Comment < ApplicationRecord
    belongs_to :contribucio
    belongs_to :user
end
