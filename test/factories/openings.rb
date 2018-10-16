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
    start_at { 1.day.from_now.beginning_of_day }
    end_at { 1.day.from_now.beginning_of_day + 5.hours }

    trait :with_calendar do
      association :calendar, strategy: :build
    end
  end
end
