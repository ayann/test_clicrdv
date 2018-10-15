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

require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
