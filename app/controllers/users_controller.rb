class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create, :flexy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      flash[:notice] = "Thank you for registering #{@user.username}!"
      # UserMailer.welcome_email(@user, login_url).deliver
      confirmation_token = EmailConfirmer.set_confirmation_token(@user)
      UserMailer.welcome_email(@user, email_confirmation_url(confirmation_token)).deliver


      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = kenny_loggins
  end

  def update
    @user = kenny_loggins
    @user.update(allowed_params)
    if @user.save
      redirect_to user_dashboard_path
    else
      render :edit
    end
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
      :image,
      :email,
      :avatar
    )
  end

end