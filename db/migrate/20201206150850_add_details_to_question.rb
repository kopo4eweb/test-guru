class AddDetailsToQuestion < ActiveRecord::Migration[5.2]
  def up
    change_table :questions do |t|
      t.change :body, :string, null: false
      t.change :test_id, :integer, null: false
    end
  end

  def down
    change_table :questions do |t|
      t.change :body, :string, null: true
      t.change :test_id, :integer, null: true
    end
  end
end
