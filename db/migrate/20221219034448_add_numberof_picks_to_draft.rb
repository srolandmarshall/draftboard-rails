class AddNumberofPicksToDraft < ActiveRecord::Migration[7.0]
  def change
    add_column :drafts, :roster_size, :integer
  end
end
