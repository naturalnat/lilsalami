class User < ActiveRecord::Base
  has_secure_password
  has_many :cats
  validates :username, uniqueness: true
  validates :email, uniqueness: true, format: {
    with: /\A[a-zA-Z0-9@.]+\z/,
  }
  validates :firstname, :lastname, presence: true
  validates :password, format: {
    with: /\A[a-zA-Z0-9!@#\$%^&\(\)]+\z/,
    message: "can only contain a-z, 0-9 and !@#$%^&*()"
  }
end
