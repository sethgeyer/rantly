class AdminRantsController < ApplicationController

  before_action :ensure_current_user_is_admin

  def index
    beginning_date = switch_to_date(params[:begin_date])
    end_date = switch_to_date(params[:end_date])

    range_of_rants = Rant.find_by_date_range(beginning_date, end_date)

    if params[:shown] == "false"
      @rants = range_of_rants.where(shown: params[:shown]).order("created_at DESC")
      @search_value = "false"
    else
      @rants = range_of_rants.order("created_at DESC")
      @search_value = "true"
    end
  end

  def show
    @rant = Rant.find(params[:id])
  end

  def update
    @rant = Rant.find(params[:id])
    @rant.shown = true
    @rant.save!
    redirect_to :back
  end

  def destroy
    Rant.find(params[:id]).destroy
  redirect_to :back
  end

  private

  def switch_to_date(date_string)
    if date_string == "" || date_string == nil
      nil
    else
      Date.strptime(date_string, '%m/%d/%Y')
    end
  end


end