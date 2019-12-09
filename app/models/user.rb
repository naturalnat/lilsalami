class User < ActiveRecord::Base
  #can have multiple cats
  has_secure_password
  has_many :cats
end
