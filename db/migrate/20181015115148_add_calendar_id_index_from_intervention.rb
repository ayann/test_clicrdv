class AddCalendarIdIndexFromIntervention < ActiveRecord::Migration
  def change
    add_index :interventions, :calendar_id
  end
end
