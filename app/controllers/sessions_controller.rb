class SessionsController < ApplicationController

  skip_before_action :ensure_current_user, only: [:index, :new, :create]

  def index

  end

  def new
    render :new, layout: false
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.first_name}"
      redirect_to user_dashboard_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end