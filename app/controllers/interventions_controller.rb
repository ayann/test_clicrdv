class InterventionsController < ApplicationController
  def new
    @intervention = Intervention.new
  end

  def create
    @intervention = Intervention.new(intervention_params)

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to new_intervention_path, notice: 'Intervention was successfully created.' }
        format.json { head :ok }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention = Intervention.find(params[:id])

    respond_to do |format|
      format.html { redirect_to new_intervention_path, notice: 'Intervention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def intervention_params
    params.require(:intervention).permit(:name, :duration, :calendar_id)
  end
end
