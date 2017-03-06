class AddDemandIdToQuestions < ActiveRecord::Migration[5.0]
  def change

    add_reference :questions, :demand, foreign_key: true
  end
end
