describe InterestingRanter do

  describe "#find_followers_to_receive_email" do

    let(:rant) {Rant.new(user_id: ranter.id, topic: "funny rant", details: "#{'d' * 142}") }
    let(:ranter) {create_user_with_a_confirmed_email({username: "funnyranter", email: "funny.ranter@gmail.com"})}

    it "returns a list of followers for a particular ranter" do
      follower1 = create_user_with_a_confirmed_email({username: "seth", email: "seth.geyer@gmail.com"})
      follower2 = create_user_with_a_confirmed_email({username: "seths", email: "seth.smith@gmail.com"})
      interesting_ranter = InterestingRanter.create(follower_id: follower1.id, followed_user_id: ranter.id)
      interesting_ranter = InterestingRanter.create(follower_id: follower2.id, followed_user_id: ranter.id)
      followers = InterestingRanter.find_followers_to_receive_email(rant)
      expect(followers).to eq(["seth.geyer@gmail.com", "seth.smith@gmail.com"])
    end

    it "returns nil if there are no followers for a particular ranter" do
      followers = InterestingRanter.find_followers_to_receive_email(rant)
      expect(followers).to eq(nil)
    end
  end

end
