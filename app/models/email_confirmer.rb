class EmailConfirmer < ActiveRecord::Base

  require 'securerandom'

  def self.set_confirmation_token(user)
    email_confirmer = EmailConfirmer.new(user_id: user.id, confirmation_token: SecureRandom.uuid)
    email_confirmer.save!
    email_confirmer.confirmation_token
  end



end