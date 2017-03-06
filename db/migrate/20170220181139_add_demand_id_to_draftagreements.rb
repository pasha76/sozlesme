class AddDemandIdToDraftagreements < ActiveRecord::Migration[5.0]
  def change
    add_column :draftagreements, :demand_id, :integer
  end
end
