# == Schema Information
#
# Table name: interventions
#
#  id          :integer          not null, primary key
#  duration    :integer
#  name        :string(255)
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#

require 'test_helper'

class InterventionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
