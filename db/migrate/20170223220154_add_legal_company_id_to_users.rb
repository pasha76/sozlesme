class AddLegalCompanyIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :legal_company_id, :integer
  end
end
