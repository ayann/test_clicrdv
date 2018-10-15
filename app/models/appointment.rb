# == Schema Information
#
# Table name: appointments
#
#  id              :integer          not null, primary key
#  customer_name   :string(255)
#  end_at          :datetime
#  start_at        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  calendar_id     :integer
#  intervention_id :integer
#
# Indexes
#
#  index_appointments_on_calendar_id      (calendar_id)
#  index_appointments_on_intervention_id  (intervention_id)
#

class Appointment < ActiveRecord::Base
  # Associations
  belongs_to :calendar
  belongs_to :intervention

  delegate :duration, to: :intervention, prefix: true, allow_nil: true

  # Validations
  with_options presence: true do
    validates :calendar_id
    validates :intervention_id
    validates :customer_name

    validates_datetime :start_at, after: :now, on: :create
    validates_datetime :end_at, after: :start_at
  end

  before_validation :generate_end_at, if: -> { start_at? }

  # validates :calendar_id, presence: true
  # validates :intervention_id, presence: true
  # validates :start_at, presence: true
  # validates :end_at, presence: true
  # validates :customer_name, presence: true

  private

  def generate_end_at
    self.end_at ||= start_at + intervention_duration.to_i.minutes
  end
end
