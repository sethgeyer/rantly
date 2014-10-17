class FavoritesController < ApplicationController

  def index
    @favorite_rants = Rant.find_users_favorite_rants(kenny_loggins.id)
  end

  def create
    favorite = kenny_loggins.favorites.create!(rant_id: params[:rant_id])
    times_favorited = Favorite.create_favorite_count(params[:rant_id])
    render :status => :created, :json => [favorite, times_favorited]
  end

  def destroy
    favorite = kenny_loggins.favorites.find(params[:id])
    rant = favorite.rant
    favorite.destroy
    times_favorited =  Favorite.create_favorite_count(rant.id)
    render :json => {times_favorited: times_favorited}
  end

end