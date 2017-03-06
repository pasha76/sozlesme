class CreateDraftsections < ActiveRecord::Migration[5.0]
  def change
    create_table :draftsections do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.belongs_to :draftagreement
      t.belongs_to :draft
      t.string :name
      t.integer :status
      t.decimal :order, :precision => 2, :scale => 2
      t.timestamps
    end
  end
end
