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
  with_options dependent: :destroy do
    has_many :interventions
    has_many :openings
    has_many :appointments
  end

  # Validations
  with_options presence: true do
    validates :name, uniqueness: true
    validates :intervals, numericality: { greater_than: 0 }
  end

  # Return all availables slots of specific intervention for this calendar
  #
  # @param intervention [Intervention] the intervention who search availabilities
  # @return [Array] the collection of availabilities
  def availabilities_for(intervention)
    TimeSlot.availables(self, intervention)
  end
end
