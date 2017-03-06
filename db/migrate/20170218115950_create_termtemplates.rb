class CreateTermtemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :termtemplates do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.string :content
      t.string :subject
      t.string :keywords
      t.integer :status
      t.timestamps
    end
  end
end
