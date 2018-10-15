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
  # test "the truth" do
  #   assert true
  # end
end
