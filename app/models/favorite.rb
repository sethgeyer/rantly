class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :rant


  def self.create_favorite_count(rant_id)
    count  = Favorite.where(rant_id: rant_id).count
    if count == 0
      ""
    else
      "#{count}-"
    end
  end



end