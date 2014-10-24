class RantsController < ApplicationController

  def index
    @rants = Rant.return_results_for_search(params[:search])
  end

  def show
    @shown_rant = Rant.find(params[:id])
    @rant_comments = RantComment.where(rant_id: @shown_rant.id)

  end

  def create
    @rant = kenny_loggins.rants.new(allowed_params)
    if @rant.save
      # followers = kenny_loggins.followers.map(&:email)

      followers = InterestingRanter.find_followers_to_receive_email(@rant)
      UserMailer.rant_email_to_followers(followers, @rant).deliver unless !followers
      render :nothing => true
    else
      errors = @rant.errors.messages
      render :json => {errors: errors}
    end
  end

  def update
    @rant = Rant.find(params[:id])
    @rant.shown = false
    @rant.save!
    redirect_to user_dashboard_path
  end

  def destroy
    kenny_loggins.rants.find(params[:id]).destroy
    redirect_to user_dashboard_path
  end

  private

  def allowed_params
    params.require(:rant).permit(
      :topic,
      :details
    )
  end

end