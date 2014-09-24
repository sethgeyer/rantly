class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @rant = Rant.new
  end




end