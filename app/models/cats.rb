# frozen_string_literal: true

class Cat < ActiveRecord::Base
  belongs_to :user

  def self.valid_params?(params)
    !params[:name].empty?
  end
end
