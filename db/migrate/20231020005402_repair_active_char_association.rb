class RepairActiveCharAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :active_character_id
    add_reference :characters, :active_user, foreign_key: { to_table: :users }
  end
end
