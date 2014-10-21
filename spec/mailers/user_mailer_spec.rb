require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do

  describe "#welcome_email" do
    it "sends an email to the newly registered user" do

      user = create_user_with_a_confirmed_email({first_name: "Seth", email: "seth.geyer@gmail.com"})
      email = UserMailer.welcome_email(user, "http://localhost:3000/login").deliver
      expect(email.subject).to eq("Welcome to Rantly")
      expect(email.to.first).to eq("seth.geyer@gmail.com")

    end
  end

  describe "#confirmation_email" do
    it "sends an email to the newly registered user asking them to confirm their email" do

      user = create_user_with_a_confirmed_email({first_name: "Seth", email: "seth.geyer@gmail.com"})
      confirmation_token = EmailConfirmer.set_confirmation_token(user)

      email = UserMailer.confirmation_email(user, confirmation_token).deliver
      expect(email.subject).to eq("Please confirm your email")
      expect(email.to.first).to eq("seth.geyer@gmail.com")

    end
  end

  describe "#rant_email_to_followers" do
    it "sends an email to any users that are following the ranter any time the ranter creates a new rant" do
      follower1 = create_user_with_a_confirmed_email({username: "seth", email: "seth.geyer@gmail.com"})
      follower2 = create_user_with_a_confirmed_email({username: "seths", email: "seth.smith@gmail.com"})
      ranter = create_user_with_a_confirmed_email({username: "funnyranter", email: "funny.ranter@gmail.com"})
      interesting_ranter = InterestingRanter.create(follower_id: follower1.id, followed_user_id: ranter.id)
      interesting_ranter = InterestingRanter.create(follower_id: follower2.id, followed_user_id: ranter.id)
      rant = Rant.create(user_id: ranter.id, topic: "funny rant", details: "#{'d' * 142}")

      email = UserMailer.rant_email_to_followers([follower1.email, follower2.email], rant).deliver
      expect(email.subject).to eq("New Rant from funnyranter")
      expect(email.to).to eq(["seth.geyer@gmail.com", "seth.smith@gmail.com"])
    end
  end




end
