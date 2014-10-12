class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    favorite.user_id = kenny_loggins.id
    favorite.rant_id = params[:rant_id]
    favorite.save!
    # redirect_to :back
    render :status => :created, :json => favorite
  end

  def index
    @favorite_rants = Rant.joins("LEFT OUTER JOIN favorites ON favorites.rant_id = rants.id where favorites.user_id = #{kenny_loggins.id}")
  end

  def destroy
    Favorite.where(id: params[:id], user_id: kenny_loggins.id).first.destroy
    render nothing: true
    # redirect_to :back
  end

end