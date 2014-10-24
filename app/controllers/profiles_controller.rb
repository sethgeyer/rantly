class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_comments = UserComment.where(user_id: @user.id)

  end

end