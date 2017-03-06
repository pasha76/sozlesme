class CreateDraftterms < ActiveRecord::Migration[5.0]
  def change
    create_table :draftterms do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.belongs_to :draftsection
      t.belongs_to :draft
      t.belongs_to :draftagreement
      t.string :content
      t.integer :status

      t.timestamps
    end
  end
end
