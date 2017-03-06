class CreateAgreementtemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :agreementtemplates do |t|
      t.string :name
      t.string :subject
      t.belongs_to :user
      t.string :status

      t.timestamps
    end
  end
end
