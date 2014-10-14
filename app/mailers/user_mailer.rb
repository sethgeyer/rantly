class UserMailer < ActionMailer::Base
  default from: "seth.geyer@gmail.com"

  def welcome_email(user, unique_login_url = login_url )
    @user = user
    @login_url = unique_login_url
    mail(to: @user.email, subject: "Welcome to Rantly")

  end



end
