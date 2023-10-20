class FixActiveUserCol < ActiveRecord::Migration[7.0]
  def change
    remove_column :characters, :active_user_id_id
    add_reference :characters, :active_user, foreign_key: { to_table: :users }
  end
end
