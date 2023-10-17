class ChangeAttendanceToCharacterFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :adventure_attendances, :adventure_attendee_id
    add_reference :adventure_attendances, :adventure_attendee, foreign_key: { to_table: :characters }
  end
end
