class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :correct, default: "Не один из вариантов", null: false
      t.references :question, foreign_key: true, null: false

      t.timestamps
    end
  end
end
