class RantsController < ApplicationController
  def create
    @rant = Rant.new(allowed_params.merge(user_id: kenny_loggins.id))
    if @rant.save
      redirect_to user_dashboard_path
    else
      @my_rants = kenny_loggins.rants
      @others_rants = Rant.where('user_id != ?', kenny_loggins.id)
      render 'dashboards/show'
    end

  end

  def destroy
    @rant = Rant.where(id: params[:id]).first
    @rant.destroy
    redirect_to user_dashboard_path
  end

  def show
    @rant = Rant.find(params[:id])
  end


  def index
      @all_searches = Rant.joins(:user).where(users: {last_name: params[:search]}) + Rant.joins(:user).where(users: {first_name: params[:search]}) + Rant.joins(:user).where(users: {username: params[:search]})
      @rants = @all_searches.uniq
  end


private
  def allowed_params
    params.require(:rant).permit(
      :topic,
      :details
    )
  end

end