class Rant < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :topic, presence: true
  validates :topic, length: {maximum: 49, message: "must be less than 50 characters"}
  validates :details, length: {minimum: 141, message: "must be more than 140 characters"}

  def self.sort_by_most_favorited(rants)
      sorted_list = rants.sort_by do |rant|
       -Favorite.where(rant_id: rant.id).count
      end
    sorted_list
  end

  def self.return_results_for_search(search_term)
    if search_term != nil && search_term != ""
      if search_term[0] == "#"


        rants_with_word = Rant.where("topic ilike ?", "%#{search_term} %") + Rant.where(topic: search_term) #+ Rant.where("details ilike ?", "%#{search_term}%")



      else
        user_searches = Rant.joins(:user).where(users: {last_name: search_term}) + Rant.joins(:user).where(users: {first_name: search_term}) + Rant.joins(:user).where(users: {username: search_term})
        rant_searches = Rant.where("topic ilike ?", "%#{search_term}%") + Rant.where("details ilike ?", "%#{search_term}%")
        (user_searches + rant_searches).uniq
      end

    else
      nil
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

  def make_hashtag_searchable
    array = self.topic.split(" ")
    linked_array = array.map do |word|
      if word[0] == "#"
        "<a href='/rants?search=%23#{word[1..word.length]}'>#{word}</a>"
      else
        word
      end
    end
    linked_array.join(" ").html_safe
  end

end