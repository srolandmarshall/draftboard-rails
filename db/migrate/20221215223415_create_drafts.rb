class CreateDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :drafts do |t|
      t.string :title
      t.date :scheduled_date

      t.timestamps
    end
  end
end
