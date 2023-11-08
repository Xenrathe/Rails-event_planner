class Character < ApplicationRecord
  include Enums

  belongs_to :user
  has_many :adventure_attendances, foreign_key: :adventure_attendee_id, dependent: :destroy
  has_many :attended_adventures, through: :adventure_attendances, source: :attended_adventure

  scope :sorted_by_level, lambda {
    order(level: :desc, created_at: :asc)
  }

  validates :name, presence: true, length: { maximum: 25 }
  validates :race, length: { maximum: 25 }
  validates :character_class, length: { maximum: 25 }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }
  validates :gender, presence: true
  validates :backstory, length: { maximum: 500 }
  validates :ruleset, presence: true
end
