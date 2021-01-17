class AddPublicToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :public, :boolean, default: false
    add_index :tests, :public
  end
end
