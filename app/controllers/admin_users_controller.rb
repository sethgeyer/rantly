class AdminUsersController < ApplicationController

  before_action :ensure_current_user_is_admin

  def index


    if params[:sort_order] == "desc"
      @users = User.all.sort_by { |user| user.rants.count}.reverse
      @sorter = "asc"
    elsif params[:sort_order] == "asc"
      @users = User.all.sort_by { |user| user.rants.count}
      @sorter = "desc"
    else
      @users = User.all
    end
  end

  def update
    @user = User.find(params[:id])
    @user.is_disabled = true
    @user.save!
    redirect_to admin_users_path
  end

end