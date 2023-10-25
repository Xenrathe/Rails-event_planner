class Character < ApplicationRecord
  include Enums

  belongs_to :user
  has_many :adventure_attendances, foreign_key: :adventure_attendee_id
  has_many :attended_adventures, through: :adventure_attendances, source: :attended_adventure

  scope :sorted_by_level, lambda {
    order(level: :desc, created_at: :asc)
  }
end
