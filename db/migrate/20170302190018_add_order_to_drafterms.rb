class AddOrderToDrafterms < ActiveRecord::Migration[5.0]
  def change
    add_column :draftterms, :section_order_no, :integer
    add_column :draftterms, :order_no, :integer
  end
end
