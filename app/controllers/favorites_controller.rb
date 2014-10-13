class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    favorite.user_id = kenny_loggins.id
    favorite.rant_id = params[:rant_id]
    favorite.save!
    times_favorited = Favorite.create_favorite_count(params[:rant_id])

    favorite_values = [favorite, times_favorited]
    # redirect_to :back
    render :status => :created, :json => favorite_values
  end

  def index
    @favorite_rants = Rant.joins("LEFT OUTER JOIN favorites ON favorites.rant_id = rants.id where favorites.user_id = #{kenny_loggins.id}")
  end

  def destroy
    favorite = kenny_loggins.favorites.find(params[:id])
    rant = favorite.rant
    favorite.destroy
    times_favorited =  Favorite.create_favorite_count(rant.id)
    render :json => {times_favorited: times_favorited}
  end

end