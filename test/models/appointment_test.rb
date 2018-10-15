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
  setup do
    @calendar     = FactoryBot.create(:calendar)
    @intervention = FactoryBot.create(:intervention, calendar: @calendar)
    @appointment  = FactoryBot.build(:appointment, calendar: @calendar, intervention: @intervention)
  end

  test 'valid appointment' do
    assert @appointment.valid?
  end

  test 'valid without end_at' do
    @appointment.end_at = nil
    assert @appointment.save
  end

  %i[start_at calendar intervention].each do |field|
    test "invalid without #{field}" do
      @appointment.public_send("#{field}=", nil)
      assert_not @appointment.save
    end
  end

  %i[end_at start_at].each do |field|
    test "invalid with #{field} before current time" do
      @appointment.public_send("#{field}=", 3.hours.ago)
      assert_not @appointment.save
    end
  end

  test 'invalid with end_at equal start_at' do
    @appointment.end_at = @appointment.start_at
    assert_not @appointment.save
  end

  test '#intervention_duration' do
    assert_respond_to(@appointment, :intervention_duration)
    assert_equal(@appointment.intervention_duration, @intervention.duration)
  end

  test 'should return a value for end_at' do
    @appointment.save
    assert @appointment.end_at
    assert_kind_of Time, @appointment.end_at
  end

  test '#end_at' do
    @appointment.save
    end_at = (@appointment.start_at + @appointment.intervention_duration.minutes)
    assert_equal(end_at, @appointment.end_at)
  end
end
