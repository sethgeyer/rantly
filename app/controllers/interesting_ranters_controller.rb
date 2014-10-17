class InterestingRantersController < ApplicationController

  def index
    @interesting_ranters = kenny_loggins.interesting_ranters
  end

  def create
    interesting_ranter = kenny_loggins.interesting_ranters.create!(
      person_id: params[:interesting_ranter_id]
    )
    render :status => :created, :json => interesting_ranter
  end

  def destroy
    kenny_loggins.interesting_ranters.find(params[:id]).destroy
    render :nothing => true
  end

end