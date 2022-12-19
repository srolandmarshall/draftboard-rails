class AddPickNumberToDraftPick < ActiveRecord::Migration[7.0]
  def change
    add_column :draft_picks, :pick_number, :integer
  end
end
