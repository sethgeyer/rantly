class DashboardsController < ApplicationController
  def show
    @rant = Rant.new
    @rants = kenny_loggins.rants

  end
end