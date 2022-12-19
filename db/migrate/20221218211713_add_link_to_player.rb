class AddLinkToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :url, :string
  end
end
