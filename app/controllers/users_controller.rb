class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create, :flexy]

  def new
    @user = User.new
    render :new, layout: "/layouts/not_logged_in_user"
  end

  def create
    @user = User.new(allowed_params)

    if @user.save
      flash[:notice] = "Thank you for registering #{@user.username}!"
      redirect_to user_dashboard_path
    else
      render :new, layout: "/layouts/not_logged_in_user"
    end
  end

  def show
    @user = User.find(params[:id])
    @rant = Rant.new
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
      :rant_frequency,
      :image
    )
  end

end