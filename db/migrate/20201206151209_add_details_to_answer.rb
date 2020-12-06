class AddDetailsToAnswer < ActiveRecord::Migration[5.2]
  def up
    change_table :answers do |t|
      t.change :correct, :string, null: false
      t.change :question_id, :integer, null: false
    end
  end

  def down
    change_table :answers do |t|
      t.change :correct, :string, null: true
      t.change :question_id, :integer, null: true
    end
  end
end
