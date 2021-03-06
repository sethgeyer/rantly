class Rant < ActiveRecord::Base

  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :topic, presence: true
  validates :topic, length: {maximum: 49, message: "must be less than 50 characters"}
  validates :details, length: {minimum: 141, message: "must be more than 140 characters"}

  def self.sort_by_most_favorited(rants)
    rants.sort_by { |rant| -rant.favorites.count }
  end

  def self.return_results_for_search(search_term)
    # binding.pry
    return nil if search_term == nil || search_term == ""

    return hashtag_search_results(search_term) if search_term[0] == "#"

    user_searches = Rant.joins(:user).where(users: {last_name: search_term}) + Rant.joins(:user).where(users: {first_name: search_term}) + Rant.joins(:user).where(users: {username: search_term})
    rant_searches = Rant.where("topic ilike ?", "%#{search_term}%") + Rant.where("details ilike ?", "%#{search_term}%")
    (user_searches + rant_searches).uniq
  end

  def self.hashtag_search_results(search_term)
    (Rant.where("topic ilike ?", "%#{search_term} %") + Rant.where(topic: search_term) + Rant.where("details ilike ?", "%#{search_term} %")).uniq
  end


  def self.find_users_favorite_rants(user_id)
    Rant.joins("LEFT OUTER JOIN favorites ON favorites.rant_id = rants.id where favorites.user_id = #{user_id}")
  end

  def self.find_by_date_range(beginning_date, end_date)
    if beginning_date && end_date
      ranged_rants = Rant.where(created_at: beginning_date.beginning_of_day .. end_date.end_of_day)
    elsif beginning_date && !end_date
      ranged_rants = Rant.where(['created_at > ?', beginning_date.beginning_of_day])
    elsif end_date && !beginning_date
      ranged_rants = Rant.where(['created_at < ?', end_date.end_of_day])
    else
      ranged_rants = Rant.all
    end
  end



  def shorten_it(length = 300)
    full_rant_as_an_array = self.details.split(" ")
    if full_rant_as_an_array.length > 300
      full_rant_as_an_array[0..length-1].join(" ") + "..."
    else
      self.details
    end
  end



end