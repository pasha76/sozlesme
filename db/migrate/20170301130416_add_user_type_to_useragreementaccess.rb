class AddUserTypeToUseragreementaccess < ActiveRecord::Migration[5.0]
  def change
    add_column :user_agreementaccesses, :user_type, :string
  end
end
