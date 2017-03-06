class CreateUserDemandaccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_demandaccesses do |t|
      t.belongs_to :user
      t.belongs_to :demand
      t.timestamps
    end
  end
end
