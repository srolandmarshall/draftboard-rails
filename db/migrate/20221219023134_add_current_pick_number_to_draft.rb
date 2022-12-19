class AddCurrentPickNumberToDraft < ActiveRecord::Migration[7.0]
  def change
    # defaults to 1
    add_column :drafts, :current_pick, :integer, default: 1
  end
end
