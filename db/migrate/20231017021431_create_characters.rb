class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :race
      t.string :class
      t.integer :level, default: 1, null: false
      t.integer :gender, default: 0, null: false
      t.text :backstory
      t.integer :ruleset, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
