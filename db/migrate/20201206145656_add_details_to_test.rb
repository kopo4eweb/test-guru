class AddDetailsToTest < ActiveRecord::Migration[5.2]
  def up
    change_table :tests do |t|
      t.change :title, :string, null: false
      t.change :level, :integer, null: false
      t.change :category_id, :integer, null: false
    end
  end

  def down
    change_table :tests do |t|
      t.change :title, :string, null: true
      t.change :level, :integer, null: true
      t.change :category_id, :integer, null: true
    end
  end
end
