class AssociateDraftsToLeague < ActiveRecord::Migration[7.0]
  def change
    # draft belongs to one league
    add_column :drafts, :fantasy_league_id, :integer
  end
end
