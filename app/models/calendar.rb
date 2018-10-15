# == Schema Information
#
# Table name: calendars
#
#  id        :integer          not null, primary key
#  intervals :integer
#  name      :string(255)
#

class Calendar < ActiveRecord::Base
  # Associations
  has_many :interventions
  has_many :openings

  # Validations
  validates :name, presence: true, uniqueness: true
end
