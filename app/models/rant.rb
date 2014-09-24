class Rant < ActiveRecord::Base

  belongs_to :user

  validates :topic, :details, presence: true
  validates :topic, length: {maximum: 49, message: "must be less than 50 characters"}
  validates :details, length: {minimum: 141, message: "must be more than 140 characters"}

  def self.sort_by_most_favorited(rants)
      sorted_list = rants.sort_by do |rant|
       -Favorite.where(rant_id: rant.id).count
      end
    sorted_list
  end

  def insert_paragraph_breaks(text)
    (text.gsub("\n", "<br/>")).html_safe
  end


end