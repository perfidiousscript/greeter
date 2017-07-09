# frozen_string_literal: true

class Guest
  include ActiveModel::Model
  extend ActiveModel::Callbacks

  validates :id, :firstName, :lastName, :reservation, presence: true

  attr_accessor :id, :firstName, :lastName, :reservation, :fullName

  def fullName
    "#{firstName} #{lastName}"
  end

  private
end
