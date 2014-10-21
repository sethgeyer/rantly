class InterestingRantersController < ApplicationController

  def index
    @followed_users = kenny_loggins.followed_users
  end

  def create
    kenny_loggins.followed_users << User.find(params[:interesting_ranter_id])
    interesting_ranter = InterestingRanter.where(follower_id: kenny_loggins.id, followed_user_id: params[:interesting_ranter_id]).first
    render :status => :created, :json => interesting_ranter
  end

  def destroy
    InterestingRanter.where(id: params[:id], follower_id: kenny_loggins.id).first.destroy
    render :nothing => true
  end

end