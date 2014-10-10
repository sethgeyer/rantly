class RantsController < ApplicationController

  def create
    @rant = Rant.new(allowed_params.merge(user_id: kenny_loggins.id))
    if @rant.save
      redirect_to user_dashboard_path
    else
      @dashboard = Dashboard.new
      render 'dashboards/show'
    end
  end

  def destroy
    Rant.where(id: params[:id]).first.destroy
    redirect_to user_dashboard_path
  end

  def show
    @shown_rant = Rant.find(params[:id])
  end

  def index
    @rants = Rant.return_results_for_search(params[:search])
  end

private
  def allowed_params
    params.require(:rant).permit(
      :topic,
      :details
    )
  end

end