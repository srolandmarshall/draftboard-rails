class AddRoundToDraftPick < ActiveRecord::Migration[7.0]
  def change
    add_column :draft_picks, :round, :integer
  end
end
