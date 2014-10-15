class RantsController < ApplicationController

  def create
    @rant = Rant.new
    @rant.topic = params[:rant_topic]
    @rant.details = params[:rant_details]
    @rant.user_id = kenny_loggins.id
    if @rant.save
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
    Rant.where(id: params[:id]).first.destroy
    redirect_to user_dashboard_path
  end

  def show
    @shown_rant = Rant.find(params[:id])
    # @comment = Comment.new

  end

  def index
    @rants = Rant.return_results_for_search(params[:search])
  end

# private
#   def allowed_params
#     params.require(:rant).permit(
#       :topic,
#       :details
#     )
#   end

end