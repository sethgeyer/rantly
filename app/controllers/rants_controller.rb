class RantsController < ApplicationController
  def create
    @rant = Rant.new(allowed_params.merge(user_id: kenny_loggins.id))
    @rant.save!
    redirect_to user_dashboard_path
  end

  def destroy
    @rant = Rant.where(id: params[:id]).first
    @rant.destroy
    redirect_to user_dashboard_path
  end

  def show
    @rant = Rant.find(params[:id])
  end



private
  def allowed_params
    params.require(:rant).permit(
      :topic,
      :details
    )
  end

end