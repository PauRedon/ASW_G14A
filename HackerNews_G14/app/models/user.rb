class User < ApplicationRecord
  validates :username, length: {minimum: 4}, presence: true
  validates :email, presence: true
  validates :password, presence: true
end