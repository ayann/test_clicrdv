# == Schema Information
#
# Table name: interventions
#
#  id          :integer          not null, primary key
#  duration    :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#
# Indexes
#
#  index_interventions_on_calendar_id  (calendar_id)
#

require 'test_helper'

class InterventionTest < ActiveSupport::TestCase
  setup do
    @calendar = FactoryBot.create(:calendar)
    @intervention = FactoryBot.build(:intervention, calendar: @calendar)
  end

  test 'valid intervention' do
    assert @intervention.valid?
  end

  %i[duration name calendar].each do |field|
    test "invalid without #{field}" do
      @intervention.public_send("#{field}=", nil)
      assert_not @intervention.save
    end
  end

  test 'invalid when duration is greater_than 60' do
    @intervention.duration = 80
    assert_not @intervention.save
  end

  test 'invalid when duration is lower_than 1' do
    @intervention.duration = 0
    assert_not @intervention.save
  end

  test 'invalid when name already taken with a same calendar' do
    @intervention.save
    @new_intervention = @intervention.dup
    assert_not @new_intervention.save
  end
end
