# == Schema Information
#
# Table name: openings
#
#  id          :integer          not null, primary key
#  end_at      :datetime
#  start_at    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#

require 'test_helper'

class OpeningTest < ActiveSupport::TestCase
  setup do
    @opening = FactoryBot.build(:opening, :with_calendar)
  end

  test 'valid opening' do
    assert @opening.valid?
  end

  %i[end_at start_at calendar].each do |field|
    test "invalid without #{field}" do
      @opening.public_send("#{field}=", nil)
      assert_not @opening.save
    end
  end

  %i[end_at start_at].each do |field|
    test "invalid with #{field} before current time" do
      @opening.public_send("#{field}=", 3.hours.ago)
      assert_not @opening.save
    end
  end

  test 'invalid with end_at equal start_at' do
    @opening.end_at = @opening.start_at
    assert_not @opening.save
  end

  test 'invalid with end_at before start_at' do
    @opening.end_at = @opening.start_at - 4.days
    assert_not @opening.save
  end
end
