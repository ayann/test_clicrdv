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
  with_options presence: true do
    validates :name, uniqueness: true
    validates :intervals, numericality: { greater_than: 0 }
  end
end
