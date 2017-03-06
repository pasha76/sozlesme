class AddOrderNoToDraftsections < ActiveRecord::Migration[5.0]
  def change
    add_column :draftsections, :order_no, :integer
  end
end
