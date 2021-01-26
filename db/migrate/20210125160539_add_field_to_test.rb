class AddFieldToTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :time_for_test, :integer, default: 0
  end
end
