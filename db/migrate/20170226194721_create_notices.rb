class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.string :content
      t.integer :notice_type
      t.string :url

      t.timestamps
    end
  end
end
