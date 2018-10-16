class CalendarsController < ApplicationController
  def show; end

  def availabilities
    @intervention   = calendar.interventions.find(params[:intervention_id])
    @availabilities = calendar.availabilities_for(@intervention)

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def calendar
    @_calendar ||= Calendar.find(params[:id])
  end
  helper_method :calendar
end
