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
  %i[end_at start_at calendar_id].each do |field|
    test "should not save opening without #{field}" do
      opening = openings(:one)
      opening.public_send("#{field}=", nil)
      assert_not opening.save
    end
  end
end
