class AdminUsersController < ApplicationController

  before_action :ensure_current_user_is_admin

  def index
    @users = User.all
  end


  def update
    @user = User.find(params[:id])
    @user.is_disabled = true
    @user.save!
    redirect_to admin_users_path
  end

end