class AddDetailsToTest < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tests, :title, false
    change_column_null :tests, :level, false

    change_column_default :tests, :level, from: nil, to: 1
  end
end
