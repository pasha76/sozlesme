class AddAgreementIdToUserAgreementaccesses < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_agreementaccesses, :agreement, foreign_key: true
  end
end
