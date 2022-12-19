class ChangeScheduledDateToDateTime < ActiveRecord::Migration[7.0]
  def change
    change_column :drafts, :scheduled_date, :datetime
  end
end
