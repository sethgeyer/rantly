class Session
  include ActiveModel::Validations

  attr_reader :user, :session

  validate :authenticated
  validate :email_is_confirmed, if: :user_authenticated?
  validate :not_disabled, if: :user_authenticated?

  def initialize(options = {})
    @username = options.fetch(:username)
    @password = options.fetch(:password)
    @session = options.fetch(:session)
    @user = User.find_by(username: @username)
  end

  def save
    return false unless valid?
    session[:user_id] = user.id
  end

  def user_authenticated?
    user && user.authenticate(@password)
  end

  def authenticated
    unless user_authenticated?
      errors.add(:base, "Login failed")
    end
  end

  def email_is_confirmed
    unless user.email_is_confirmed?
      errors.add(:base, "You must confirm your email prior to logging in.  Please see your confirmation")
    end
  end

  def not_disabled
    if user.is_disabled?
      errors.add(:base, "Your account has been disabled")
    end
  end


end