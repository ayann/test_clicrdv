# == Schema Information
#
# Table name: calendars
#
#  id          :integer          not null, primary key
#  end_at      :datetime
#  start_at    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#

require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  setup do
    @calendar = FactoryBot.build(:calendar)
  end

  test 'valid calendar' do
    assert @calendar.valid?
  end

  %i[intervals name].each do |field|
    test "invalid without #{field}" do
      @calendar.public_send("#{field}=", nil)
      assert_not @calendar.save
    end
  end

  test 'invalid when name already taken' do
    assert @calendar.save
    @new_calendar = @calendar.dup
    assert_not @new_calendar.save
  end

  test 'invalid when intervals is lower than 0' do
    @calendar.intervals = rand(-100..-1)
    assert_not @calendar.save
  end

  test 'respond_to availabilities_for' do
    assert_respond_to(@calendar, :availabilities_for)
  end

  test 'raise error when intervention not pass to parameter' do
    assert_raises(ArgumentError) { @calendar.availabilities_for }
  end
end
