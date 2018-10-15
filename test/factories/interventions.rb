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

FactoryBot.define do
  factory :intervention do
    calendar_id { nil }
    name { ['Massage', 'Hair remove', 'Consultation'].sample }
    duration { (10..60).step(10).to_a.sample }
  end
end
