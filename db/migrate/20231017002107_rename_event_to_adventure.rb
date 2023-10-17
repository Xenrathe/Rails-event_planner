class RenameEventToAdventure < ActiveRecord::Migration[7.0]
  def change
    rename_table :events, :adventures
  end
end
