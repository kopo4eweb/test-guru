class AddDefaultLevelToAnswer < ActiveRecord::Migration[5.2]
  def up
    change_table :answers do |t|
      t.change :correct, :string, default: 'Не один из вариантов'
    end
  end

  def down
    change_table :answers do |t|
      t.change :correct, :string, default: nil
    end
  end
end
