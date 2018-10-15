class AddIndexesToAppointments < ActiveRecord::Migration
  def change
    add_index :appointments, :calendar_id
    add_index :appointments, :intervention_id
  end
end
