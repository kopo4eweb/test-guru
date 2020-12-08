class CreateTestsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :tests_users do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true
      t.boolean :owner, default: false

      t.timestamps
    end
  end
end
