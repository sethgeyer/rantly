class AdminUsersController < ApplicationController

  before_action :ensure_current_user_is_admin

  def index
    @users = User.all
  end

end