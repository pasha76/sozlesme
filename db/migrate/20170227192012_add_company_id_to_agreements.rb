class AddCompanyIdToAgreements < ActiveRecord::Migration[5.0]
  def change
    add_column :agreements, :company_id, :integer
  end
end
