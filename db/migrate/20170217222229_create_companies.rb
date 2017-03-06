class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :tax_no
      t.integer :status

      t.timestamps
    end
  end
end
