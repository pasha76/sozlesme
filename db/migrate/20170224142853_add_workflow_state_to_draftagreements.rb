class AddWorkflowStateToDraftagreements < ActiveRecord::Migration[5.0]
  def change
    add_column :draftagreements, :workflow_state, :string
  end
end
