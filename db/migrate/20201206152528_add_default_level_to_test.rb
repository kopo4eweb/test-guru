class AddDefaultLevelToTest < ActiveRecord::Migration[5.2]
  def up
    change_table :tests do |t|
      t.change :level, :integer, default: 1
    end
  end

  def down
    change_table :tests do |t|
      t.change :level, :integer, default: nil
    end
  end
end
