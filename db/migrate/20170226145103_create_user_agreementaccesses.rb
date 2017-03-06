class CreateUserAgreementaccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_agreementaccesses do |t|

      t.belongs_to :user
      t.belongs_to :draftagreement
      t.timestamps
    end
  end
end
