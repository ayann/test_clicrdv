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
  # test "the truth" do
  #   assert true
  # end
end
