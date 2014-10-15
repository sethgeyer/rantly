class UserMailer < ActionMailer::Base
  default from: 'notifications@rantly.com-no-reply'

  def welcome_email(user, login_url )
    @user = user
    @login_url = login_url
    mail(to: @user.email, subject: "Welcome to Rantly")

  end

  def confirmation_email(user, url)
    @user = user
    @confirmation_url = url
    mail(to: @user.email, subject: "Please confirm your email")
  end

  def rant_email_to_followers(users, rant)
    @users = users
    @ranter_username = rant.user.username
    @rant_url = rant_url(rant.id)
    mail(to: @users, subject: "New Rant from #{@ranter_username}")

  end


end
