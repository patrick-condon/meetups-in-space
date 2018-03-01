class Meetup < ActiveRecord::Base
  has_many :appearances
  has_many :users, through: :appearances
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :creator, presence: true
end
