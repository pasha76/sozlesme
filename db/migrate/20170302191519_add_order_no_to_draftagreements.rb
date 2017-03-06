class AddOrderNoToDraftagreements < ActiveRecord::Migration[5.0]
  def change
    add_column :draftagreements, :order_no, :integer
  end
end
