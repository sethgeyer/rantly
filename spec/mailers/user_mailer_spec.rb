require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do

  describe "#welcome_email" do
  it "sends an email to the newly registered user" do

    user = create_user({first_name: "Seth", email: "seth.geyer@gmail.com"})
    email = UserMailer.welcome_email(user, "http://localhost:3000/login").deliver
    expect(email.subject).to eq("Welcome to Rantly")
    expect(email.to.first).to eq("seth.geyer@gmail.com")

  end
  end

  describe "#confirmation_email" do
  it "sends an email to the newly registered user asking them to confirm their email" do

    user = create_user({first_name: "Seth", email: "seth.geyer@gmail.com"})
    confirmation_token = EmailConfirmer.set_confirmation_token(user)

    email = UserMailer.confirmation_email(user, confirmation_token).deliver
    expect(email.subject).to eq("Please confirm your email")
    expect(email.to.first).to eq("seth.geyer@gmail.com")

  end
  end


end
