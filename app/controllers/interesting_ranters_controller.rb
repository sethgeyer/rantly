class InterestingRantersController < ApplicationController
  def create
    interesting_ranter = InterestingRanter.new
    interesting_ranter.user_id = kenny_loggins.id
    interesting_ranter.person_id = params[:interesting_ranter_id]
    interesting_ranter.save!
    redirect_to dashboard_path
  end

  def index
    @interesting_ranters = kenny_loggins.interesting_ranters
  end

  def destroy
    interesting_ranter = InterestingRanter.find(params[:id])
    interesting_ranter.destroy
    redirect_to :back
  end
end