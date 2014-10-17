class SessionsController < ApplicationController

  skip_before_action :ensure_current_user, only: [:index, :new, :create]

  def index
    if cookies[:visitor]
      flash.now[:notice] = "Welcome Back Stranger!"
    else
      cookies[:visitor] = "visitor"
    end
    render :index, layout: "/layouts/homepage"
  end

  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      if user.email_is_confirmed?
        if user.is_disabled?
          flash.now[:notice] = "Your account has been disabled"
          render :new
        else
          session[:user_id] = user.id
          Keen.publish(:logins, {username: user.username, login_date: DateTime.now()})
          flash[:notice] = "Welcome #{user.first_name}"
          redirect_to user_dashboard_path
        end
      else
        flash.now[:notice] = "You must confirm your email prior to logging in.  Please see your confirmation email and follow the instructions."
        render :new
      end
    else
      flash.now[:notice] = "Login failed"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

end

