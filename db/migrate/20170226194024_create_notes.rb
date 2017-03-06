class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user
      t.belongs_to :agreement
      t.belongs_to :term
      t.string :content
      t.string :workflow_state

      t.timestamps
    end
  end
end
