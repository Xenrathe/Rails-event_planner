class Adventure < ApplicationRecord
  include Enums

  belongs_to :creator, class_name: "User"
  has_many :adventure_attendances, foreign_key: :attended_adventure_id, dependent: :destroy
  has_many :attendees, through: :adventure_attendances, source: :adventure_attendee

  scope :past, -> { where('date < ?', DateTime.now) }
  scope :upcoming, -> { where('date >= ?', DateTime.now) }
  scope :by_ruleset, -> (ruleset) { where('ruleset = ?', ruleset) }
  scope :by_level_range, ->(min_lvl, max_lvl) { where('min_level >= ? AND max_level <= ?', min_lvl, max_lvl) }
  scope :compatible_with_active_character, lambda  { |user|
    if user.active_character.present?
      where('adventures.ruleset = ? AND min_level <= ? AND max_level >= ?', 
      Character.rulesets[user.active_character.ruleset], 
      user.active_character.level, 
      user.active_character.level) 
    end
  }
  scope :open, lambda {
    left_joins(:adventure_attendances)
      .group(:id)
      .having('COUNT(adventure_attendances.id) < adventures.max_seats')
  }
  scope :virtual, -> { where('platform > ?', 2) }
  scope :in_person, -> { where('platform <= ?', 2) }
  scope :is_public, -> { where('is_private = ?', false) }
  scope :is_private, -> { where('is_private = ?', true) }
  scope :attending, ->(user) { joins(attendees: :user).where('characters.user_id = ?', user.id) }

  validates :name, presence: true, length: { maximum: 40 }
  validates :module, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 500}
  validates :max_seats, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :min_age, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 99 }
  validates :min_level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 99 }
  validates :max_level, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 99 }

end
