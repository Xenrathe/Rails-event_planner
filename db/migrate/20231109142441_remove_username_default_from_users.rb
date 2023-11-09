class RemoveUsernameDefaultFromUsers < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :username, nil
  end

  def down
    change_column_default :users, :username, "default"
  end
end
