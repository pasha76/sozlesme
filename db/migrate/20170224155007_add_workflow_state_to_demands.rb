class AddWorkflowStateToDemands < ActiveRecord::Migration[5.0]
  def change
    add_column :demands, :workflow_state, :string
  end
end
