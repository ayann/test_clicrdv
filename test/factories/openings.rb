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

FactoryBot.define do
  factory :opening do
    start_at { 1.hour.from_now.beginning_of_hour }
    end_at { 5.hours.from_now.beginning_of_hour }

    trait :with_calendar do
      association :calendar, strategy: :build
    end
  end
end
