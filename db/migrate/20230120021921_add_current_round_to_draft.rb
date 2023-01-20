class AddCurrentRoundToDraft < ActiveRecord::Migration[7.0]
  def change
    add_column :drafts, :current_round, :integer
  end
end
