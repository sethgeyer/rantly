class UsersController < ApplicationController
  skip_before_action :ensure_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.bio = params[:user][:bio]
    @user.rant_frequency = params[:user][:rant_frequency]
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for registering #{@user.username}!"
      redirect_to root_path
    else
      render :new
    end

  end

end