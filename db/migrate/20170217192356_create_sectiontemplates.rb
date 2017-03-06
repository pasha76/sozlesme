class CreateSectiontemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :sectiontemplates do |t|
      t.string :name
      t.string :subject
      t.belongs_to :user
      t.belongs_to :agreementtemplate
      t.timestamps
    end
  end
end
