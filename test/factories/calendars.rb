# == Schema Information
#
# Table name: calendars
#
#  id        :integer          not null, primary key
#  intervals :integer
#  name      :string(255)
#

FactoryBot.define do
  factory :calendar do
    name { SecureRandom.hex }
    intervals { [10, 20, 30].sample }
  end
end
