class Appearance < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup
  validates :user_id, uniqueness: { scope: :meetup_id, message: "on list. You're already signed up!"}
end
