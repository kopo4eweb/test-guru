class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def up
    change_table :users do |t|
      t.change :name, :string, null: false
    end
  end

  def down
    change_table :users do |t|
      t.change :name, :string, null: true
    end
  end
end
