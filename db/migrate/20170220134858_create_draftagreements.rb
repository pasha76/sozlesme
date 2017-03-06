class CreateDraftagreements < ActiveRecord::Migration[5.0]
  def change
    create_table :draftagreements do |t|
      t.belongs_to :company
      t.belongs_to :user
      t.integer :purchaser_company_id
      t.integer :vendor_company_id
      t.integer :status
      t.string :name
      t.timestamps
    end
  end
end
