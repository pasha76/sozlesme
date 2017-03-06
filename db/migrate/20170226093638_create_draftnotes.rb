class CreateDraftnotes < ActiveRecord::Migration[5.0]
  def change
    create_table :draftnotes do |t|
      t.belongs_to :user
      t.belongs_to :draftagreement
      t.string :content
      t.string :workflow_state
      t.timestamps
    end
  end
end
