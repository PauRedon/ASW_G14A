class Contribucion < ApplicationRecord
  validates :title, length: {minimum: 4}, presence: true
  validates :content, presence: false, if: -> { validates :url, presence: true}
  validates :url, presence: false, if: -> { validates :content, presence: true}
end
