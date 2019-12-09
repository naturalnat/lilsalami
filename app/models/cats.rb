class Cat < ActiveRecord::Base
  # has_secure_password
  belongs_to :user

  def self.valid_params?(params)
    return !params[:name].empty?
  end
end
