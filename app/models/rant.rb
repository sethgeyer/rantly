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

  def self.return_results_for_search(search_term)
    if search_term != nil && search_term != ""
      user_searches = Rant.joins(:user).where(users: {last_name: search_term}) + Rant.joins(:user).where(users: {first_name: search_term}) + Rant.joins(:user).where(users: {username: search_term})
      rant_searches = Rant.where("topic ilike ?", "%#{search_term}%") + Rant.where("details ilike ?", "%#{search_term}%")
      (user_searches + rant_searches).uniq
    else
      nil
    end
  end

end