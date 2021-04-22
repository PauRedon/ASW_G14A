class Vote < ApplicationRecord
    validates :user_id, uniqueness: {scope: :contribucio_id, message: 'Only one vote per user'}
end
