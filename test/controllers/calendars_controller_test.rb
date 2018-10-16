require 'test_helper'

class CalendarsControllerTest < ActionController::TestCase
  setup do
    @calendar     = calendars(:one)
    @intervention = interventions(:one)
  end

  test 'should get show' do
    get :show, id: @calendar
    assert_response :success
  end

  test 'should get availabilities format html' do
    get :availabilities, id: @calendar, intervention_id: @intervention
    assert_response :success
  end

  test 'should get availabilities format json' do
    get :availabilities, id: @calendar, intervention_id: @intervention, format: :json
    assert_response :success
  end
end
