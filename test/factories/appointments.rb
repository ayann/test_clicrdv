# == Schema Information
#
# Table name: appointments
#
#  id              :integer          not null, primary key
#  customer_name   :string(255)
#  end_at          :datetime
#  start_at        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  calendar_id     :integer
#  intervention_id :integer
#
# Indexes
#
#  index_appointments_on_calendar_id      (calendar_id)
#  index_appointments_on_intervention_id  (intervention_id)
#

FactoryBot.define do
  factory :appointment do
    customer_name { ['Jean Pierre Foucault', 'John Doe', 'Patrick Sebastien'].sample }
    start_at { 1.day.from_now.beginning_of_day + rand(1..4).hours }
    calendar_id { nil }
    intervention_id { nil }
  end
end
