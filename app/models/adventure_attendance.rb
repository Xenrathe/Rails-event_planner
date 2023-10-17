class AdventureAttendance < ApplicationRecord
  belongs_to :adventure_attendee, class_name: "User"
  belongs_to :attended_adventure, class_name: "Adventure"
end
