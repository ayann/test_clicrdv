FactoryBot.define do
  factory :opening do
    start_at { 1.hour.from_now.beginning_of_hour }
    end_at { 5.hours.from_now.beginning_of_hour }

    trait :with_calendar do
      association :calendar, strategy: :build
    end
  end
end
