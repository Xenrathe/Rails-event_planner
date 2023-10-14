class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  enum event_type: { party: 0, holiday: 1, music: 2, performance_arts: 3, health: 4, hobbies: 5, business: 6, food_and_drink: 7 }
end
