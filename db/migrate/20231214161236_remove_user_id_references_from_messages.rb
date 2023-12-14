class RemoveUserIdReferencesFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_reference :messages, :user, index: true, foreign_key: true
  end
end
