class AddBirthdateUsernameBioColsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthdate, :date, null: false, default: Date.new(2000, 1, 1)
    add_column :users, :bio, :text
    add_column :users, :username, :string, null: false, default: 'default'
    add_index :users, :username, unique: true
  end
end
