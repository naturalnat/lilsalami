class User < ActiveRecord::Base
  has_secure_password
  has_many :cats
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :firstname, presence: true
end
