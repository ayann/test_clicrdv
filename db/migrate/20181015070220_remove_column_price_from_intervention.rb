class RemoveColumnPriceFromIntervention < ActiveRecord::Migration
  def change
    remove_column :interventions, :price
  end
end
