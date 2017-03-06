class AddCompanyIdToAgreementtemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :agreementtemplates, :company_id, :integer
  end
end
