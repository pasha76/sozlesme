class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
