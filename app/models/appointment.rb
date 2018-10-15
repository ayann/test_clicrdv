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

  # Validations
  validates :calendar_id, presence: true
  validates :intervention_id, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :customer_name, presence: true
end
