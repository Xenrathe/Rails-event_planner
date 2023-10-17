class AdventureAttendance < ApplicationRecord
  belongs_to :adventure_attendee, class_name: "Character"
  belongs_to :attended_adventure, class_name: "Adventure"
end
