class AddPortraitPathToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :portrait_path, :string
  end
end
