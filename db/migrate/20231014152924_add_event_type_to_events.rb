class AddEventTypeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_type, :integer
  end
end
