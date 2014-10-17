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
    beginning_date = switch_to_date(params[:begin_date])
    end_date = switch_to_date(params[:end_date])
    if beginning_date && end_date
      ranged_rants = Rant.where(created_at: beginning_date.beginning_of_day .. end_date.end_of_day)
    elsif beginning_date && !end_date
      ranged_rants = Rant.where(['created_at > ?', beginning_date.beginning_of_day])
    elsif end_date && !beginning_date
      ranged_rants = Rant.where(['created_at < ?', end_date.end_of_day])
    else
      ranged_rants = Rant.all
    end

    if params[:shown] == "false"
      @rants = ranged_rants.where(shown: params[:shown]).order("created_at DESC")
      @search_value = "false"
    else
      @rants = ranged_rants.order("created_at DESC")
      @search_value = "true"
    end
  end

  def destroy
    deleted_rant = Rant.find(params[:id]).destroy
  redirect_to :back
  end


  def switch_to_date(date_string)
    if date_string == "" || date_string == nil
      nil
    else
      Date.strptime(date_string, '%m/%d/%Y')
    end
  end


end