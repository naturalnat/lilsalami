class Cat < ActiveRecord::Base
  #1-1 association with user
  belongs_to :user

  def self.valid_params?(params)
    return !params[:name].empty?
  end
end
