class CreateAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :agreements do |t|
      t.belongs_to :user
      t.belongs_to :draftagreement
      t.belongs_to :agreementtemplate
      t.belongs_to :demand
      t.string :name
      t.string :workflow_state

      t.timestamps
    end
  end
end
