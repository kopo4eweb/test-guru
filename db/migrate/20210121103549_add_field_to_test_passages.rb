class AddFieldToTestPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :test_passages, :percent, :integer, default: 0
  end
end
