require 'test_helper'

class InterventionsControllerTest < ActionController::TestCase
  setup do
    @intervention = interventions(:one)
    @calendar = calendars(:one)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create intervention' do
    assert_difference('Intervention.count') do
      post :create, intervention: {
        calendar_id: @intervention.calendar_id,
        duration: @intervention.duration,
        name: 'Intervention Another 2'
      }
    end

    assert_redirected_to new_intervention_path
  end

  test 'should destroy intervention' do
    assert_difference('Intervention.count', -1) do
      delete :destroy, id: @intervention
    end

    assert_redirected_to new_intervention_path
  end
end
