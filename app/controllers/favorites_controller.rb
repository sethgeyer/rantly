class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new
    @favorite.user_id = kenny_loggins.id
    @favorite.rant_id = params[:rant_id]
    @favorite.save!
    redirect_to :back
  end


  def index
    @favorites = kenny_loggins.favorites
  end

  def destroy
    @favorite = Favorite.where(id: params[:id], user_id: kenny_loggins.id).first
    @favorite.destroy
    redirect_to :back
  end


end