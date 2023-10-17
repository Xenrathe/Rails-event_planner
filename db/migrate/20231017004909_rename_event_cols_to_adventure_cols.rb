class RenameEventColsToAdventureCols < ActiveRecord::Migration[7.0]
  def change
    rename_column :event_attendances, :event_attendee_id, :adventure_attendee_id
    rename_column :event_attendances, :attended_event_id, :attended_adventure_id
  end
end
