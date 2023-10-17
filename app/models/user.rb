class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adventures, foreign_key: :creator_id
  has_many :characters
  has_one :active_character, class_name: 'Character', foreign_key: 'user_id', dependent: :nullify
end
