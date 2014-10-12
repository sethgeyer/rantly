class AdminRantsController < ApplicationController

  before_action :ensure_current_user_is_admin



  def index
  @rants = Rant.all.order("created_at DESC")
    end




end