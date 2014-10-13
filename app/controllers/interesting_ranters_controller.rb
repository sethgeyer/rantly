class InterestingRantersController < ApplicationController

  def create
    interesting_ranter = InterestingRanter.new
    interesting_ranter.user_id = kenny_loggins.id
    interesting_ranter.person_id = params[:interesting_ranter_id]
    interesting_ranter.save!
    render :status => :created, :json => interesting_ranter
  end

  def index
    @interesting_ranters = kenny_loggins.interesting_ranters
  end

  def destroy
    InterestingRanter.find(params[:id]).destroy
    render :nothing => true
  end

end