class ChangeAdventureDateNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :adventures, :date, false
  end
end
