class AdminUsersController < ApplicationController

  before_action :ensure_current_user_is_admin

  def index
    sort_order = params[:sort_order]

    if sort_order
      @users = User.all.sort_by { |user| user.rants.count}
      @sorter = "desc"
      if sort_order == "desc"
        @users.reverse!
        @sorter = "asc"
      end
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