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

class Intervention < ActiveRecord::Base
  # Associations
  belongs_to :calendar

  # Validations
  with_options presence: true do
    validates :name
    validates :duration, inclusion: 1..60
  end
end
