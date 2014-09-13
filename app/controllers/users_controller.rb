class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    # if @user.save
    #   session[:user_id] = @user.id
    #   flash[:notice] = "Thank you for registering #{@user.username}!"
    #   redirect_to root_path
    # else
    #   render :new
    # end


    render :new unless @user.save
    # session[:user_id] = @user.id
    flash[:notice] = "Thank you for registering #{@user.username}!"
    redirect_to user_dashboard_path

  end

  def show
    @user = User.find(params[:id])
  end


  def update
    @user = User.find_by(username: kenny_loggins.username)
    @user.update(allowed_params)
    @user.save!
    redirect_to user_dashboard_path
  end

  private

  def allowed_params
    params.require(:user).permit(
      :username,
      :password,
      :first_name,
      :last_name,
      :bio,
      :rant_frequency
    )
  end

end