class UpdateAdventureWithNewCols < ActiveRecord::Migration[7.0]
  def change
    rename_column :adventures, :event_type, :ruleset
    change_column :adventures, :date, :datetime
    add_column :adventures, :module, :string
    add_column :adventures, :description, :text
    add_column :adventures, :platform, :integer
    add_column :adventures, :max_seats, :integer
    add_column :adventures, :min_age, :integer
    add_column :adventures, :min_level, :integer
    add_column :adventures, :max_level, :integer
    add_column :adventures, :address, :string
    add_column :adventures, :is_private, :boolean, default: true
  end
end
