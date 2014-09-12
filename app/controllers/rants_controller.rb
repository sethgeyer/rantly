class RantsController < ApplicationController
  def create
    @rant = Rant.new(allowed_params.merge(user_id: kenny_loggins.id))
    @rant.save!
    redirect_to dashboard_path
  end

  def destroy
    @rant = Rant.where(id: params[:id], user_id: kenny_loggins.id).first
    @rant.destroy
    redirect_to dashboard_path
  end



private
  def allowed_params
    params.require(:rant).permit(
      :topic,
      :details
    )
  end

end