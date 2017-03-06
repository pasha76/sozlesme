class AddAgreementtemplateIdToDraftagreement < ActiveRecord::Migration[5.0]
  def change
    add_column :draftagreements, :agreementtemplate_id, :integer
  end
end
