class VoteComment < ApplicationRecord
    validates :user_id, uniqueness: {scope: :comment_id, message: 'Only one vote per user'}
end
