class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :usage_limit, default: 1000000
      t.text :rule
      t.boolean :active, default: false

      t.timestamps
    end

    add_index :badges, :active
  end
end
