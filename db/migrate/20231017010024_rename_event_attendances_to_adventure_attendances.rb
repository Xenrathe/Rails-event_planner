class RenameEventAttendancesToAdventureAttendances < ActiveRecord::Migration[7.0]
  def change
    rename_table :event_attendances, :adventure_attendances
  end
end
