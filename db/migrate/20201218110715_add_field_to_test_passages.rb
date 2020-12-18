class AddFieldToTestPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :test_passages, :passed_questions, :integer

    change_column_default :test_passages, :passed_questions, from: nil, to: 1
  end
end
