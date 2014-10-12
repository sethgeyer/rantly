class AdminRantsController < ApplicationController
  def index
  @rants = Rant.all.order("created_at DESC")
    end




end