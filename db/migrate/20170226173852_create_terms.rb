class CreateTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :terms do |t|
      t.belongs_to :draftagreement
      t.belongs_to :user
      t.belongs_to :section
      t.belongs_to :company
      t.string :content
      t.string :workflow_state

      t.timestamps
    end
  end
end
