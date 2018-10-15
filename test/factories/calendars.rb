FactoryBot.define do
  factory :calendar do
    name { SecureRandom.hex }
    intervals { [10, 20, 30].sample }
  end
end
