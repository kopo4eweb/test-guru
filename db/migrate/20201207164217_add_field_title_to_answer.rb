class AddFieldTitleToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :title, :string
    
    change_column_null :answers, :title, false
  end
end
