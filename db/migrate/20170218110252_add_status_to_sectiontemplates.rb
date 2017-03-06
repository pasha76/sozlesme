class AddStatusToSectiontemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :sectiontemplates, :status, :integer
  end
end
