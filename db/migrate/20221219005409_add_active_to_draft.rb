class AddActiveToDraft < ActiveRecord::Migration[7.0]
  def change
    add_column :drafts, :active, :boolean
    Draft.all.each do |draft|
      draft.update(active: false)
    end
  end
end
