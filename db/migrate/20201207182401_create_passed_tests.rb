class CreatePassedTests < ActiveRecord::Migration[5.2]
  def change
    create_table :passed_tests do |t|
      t.references :user, foreign_key: true, null: false
      t.references :test, foreign_key: true, null: false

      t.timestamps
    end
  end
end
