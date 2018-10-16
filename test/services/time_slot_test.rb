require 'test_helper'

class TimeSlotTest < ActiveSupport::TestCase
  setup do
    @calendar = FactoryBot.create(:calendar, intervals: 10)

    @opening = FactoryBot.create(
      :opening,
      calendar: @calendar,
      start_at: '2018-11-01 08:00:00',
      end_at: '2018-11-01 12:00:00'
    )

    @massage = FactoryBot.create(
      :intervention,
      calendar: @calendar,
      duration: 30,
      name: 'Massage'
    )

    @hair_remove = FactoryBot.create(
      :intervention,
      calendar: @calendar,
      duration: 40, name: 'Hair remove'
    )

    FactoryBot.create(
      :appointment,
      calendar: @calendar,
      intervention: @massage,
      start_at: '2018-11-01 09:00:00'
    )

    FactoryBot.create(
      :appointment,
      calendar: @calendar,
      intervention: @hair_remove,
      start_at: '2018-11-01 10:00:00'
    )

    @service = TimeSlot.new(@calendar, @massage)
  end

  %i[openings intervals appointments].each do |meth|
    test "##{meth}" do
      assert_respond_to(@service, meth)
      assert_equal(@service.public_send(meth), @calendar.public_send(meth))
    end
  end

  test '#duration' do
    assert_respond_to(@service, :duration)
    assert_equal(@service.duration, 30)
  end

  test 'should have class method named #all' do
    assert_respond_to(TimeSlot, :all)
  end

  test '.all and #all return a same value' do
    assert_equal(@service.all, TimeSlot.all(@calendar, @massage))
  end

  test 'should have class method named #availables' do
    assert_respond_to(TimeSlot, :availables)
  end

  test '.availables and #availables return a same value' do
    assert_equal(@service.availables, TimeSlot.availables(@calendar, @massage))
  end

  test '#all return a array of slots' do
    assert_kind_of(Array, @service.all)
  end

  test '#availables return a array of availables slots' do
    assert_kind_of(Array, @service.availables)
  end

  test '#all slots not empty' do
    assert(@service.all.any?)
  end

  test '#availables slots not empty' do
    assert(@service.availables.any?)
  end

  test 'availables slots should not contains appointments slots' do
    @calendar.appointments.each do |appointment|
      assert_not_includes(@service.availables, appointment.start_at)
    end
  end
end
