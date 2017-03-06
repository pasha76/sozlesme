class CreateDemands < ActiveRecord::Migration[5.0]
  def change
    create_table :demands do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.string :content
      t.integer :to_role
      t.integer :status

      t.timestamps
    end
  end
end
