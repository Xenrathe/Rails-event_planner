class Adventure < ApplicationRecord
  include Enums

  belongs_to :creator, class_name: "User"
  has_many :adventure_attendances, foreign_key: :attended_adventure_id
  has_many :attendees, through: :adventure_attendances, source: :adventure_attendee

  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :virtual, -> { where('platform > ?', 2) }
  scope :in_person, -> { where('platform <= ?', 2) }
  scope :public, -> { where('is_private == ?', false) }
  scope :private, -> { where('is_private == ?', true) }
end
