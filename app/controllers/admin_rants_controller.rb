class AdminRantsController < ApplicationController

  before_action :ensure_current_user_is_admin


  def update
    @rant = Rant.find(params[:id])
    @rant.shown = true
    @rant.save!
      redirect_to :back
  end

  def show
    @rant = Rant.find(params[:id])
  end

  def index
    if params[:shown]
      @rants = Rant.where(shown: params[:shown]).order("created_at DESC")
    else
      @rants = Rant.all.order("created_at DESC")
    end
  end

  def destroy
    deleted_rant = Rant.find(params[:id]).destroy
  redirect_to :back
  end


end