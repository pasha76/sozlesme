class AddVendorCompanyIdToDemands < ActiveRecord::Migration[5.0]
  def change
    add_column :demands, :vendor_company_id, :integer
  end
end
