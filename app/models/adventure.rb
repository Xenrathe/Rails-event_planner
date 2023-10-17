class Adventure < ApplicationRecord
  belongs_to :creator, class_name: "User"
  enum event_type: { party: 0, holiday: 1, music: 2, performance_arts: 3, health: 4, hobbies: 5, business: 6, food_and_drink: 7 }

  has_many :adventure_attendances, foreign_key: :attended_adventure_id
  has_many :attendees, through: :adventure_attendances, source: :adventure_attendee

  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date >= ?', Date.today) }
end
