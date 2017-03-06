class AddCompanyIdToSectiontemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :sectiontemplates, :company_id, :integer
  end
end
