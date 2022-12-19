class AddOrderToDraft < ActiveRecord::Migration[7.0]
  def change
    add_column :drafts, :order, :jsonb
  end
end
