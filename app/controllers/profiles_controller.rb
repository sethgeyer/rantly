class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_comments = @user.comments.all

  end

end