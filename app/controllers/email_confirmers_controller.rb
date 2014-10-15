class EmailConfirmersController < ApplicationController

  skip_before_action :ensure_current_user, only: [:destroy]

  def destroy
  email_confirmer = EmailConfirmer.find_by_confirmation_token(params[:confirmation_token])
    if !email_confirmer
      flash[:notice] = "email you confirmed is not valid."
      redirect_to root_path
    else
      user = User.find(email_confirmer.user_id)
      user.email_is_confirmed = true
      if user.save!
        email_confirmer.destroy
        flash[:notice] = "Thanks for confirming your email.  Please login"
        redirect_to login_path
      end

    end
  end



end