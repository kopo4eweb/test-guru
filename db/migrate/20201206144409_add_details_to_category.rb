class AddDetailsToCategory < ActiveRecord::Migration[5.2]
  def up
    change_table :categories do |t|
      t.change :title, :string, null: false
    end
  end

  def down
    change_table :categories do |t|
      t.change :title, :string, null: true
    end
  end
end
