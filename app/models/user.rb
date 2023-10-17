class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adventures, foreign_key: :creator_id
  has_many :adventure_attendances, foreign_key: :adventure_attendee_id
  has_many :attended_adventures, through: :adventure_attendances, source: :attended_adventure
end
