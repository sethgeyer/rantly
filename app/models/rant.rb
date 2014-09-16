class Rant < ActiveRecord::Base
  belongs_to :user

  validates :topic, :details, presence: true
  validates :topic, length: {maximum: 49, message: "must be less than 50 characters"}
  validates :details, length: {minimum: 141, message: "must be more than 140 characters"}

end