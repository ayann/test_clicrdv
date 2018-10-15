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

class Opening < ActiveRecord::Base
  # Association
  belongs_to :calendar

  # Presence validations
  with_options presence: true do
    validates :calendar
    validates :start_at
    validates :end_at
  end
end
