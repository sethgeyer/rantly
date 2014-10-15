describe EmailConfirmer do

  describe "#set_confirmation_token" do
    it "sets a confirmation token for the newly registered user" do
      new_user = create_user({first_name: "seth"})
      token = EmailConfirmer.set_confirmation_token(new_user)
      expect(token).to eq(EmailConfirmer.where(user_id: new_user.id).first.confirmation_token)
    end
  end


end