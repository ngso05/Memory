class User < ApplicationRecord
  has_secure_password

  validates :mail, presence: true, uniqueness: true
  has_many :memos, dependent: :destroy
end
