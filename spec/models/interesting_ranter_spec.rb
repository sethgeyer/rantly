describe InterestingRanter do
  before(:each) do
    @seth = create_user
    @adam = create_user({username: "adam", first_name: "Adam"})
    @leah = create_user({username: "leah", first_name: "Leah"})
    @interesting_ranter = create_interesting_ranter({user_id: @seth.id, person_id: @adam.id})
    @rant_from_interesting_ranter = create_rant(1, {user_id: @adam.id})
    @rant_from_non_interesting_ranter = create_rant(2, {user_id: @leah.id})
  end
  describe "#build follow or unfollow link" do

    it "returns 'Unfollow link' if the ranter is already identified as a person of interest" do
      result = InterestingRanter.build_follow_or_unfollow_link(@seth, @rant_from_interesting_ranter)
      expect(result).to include('Unfollow')
    end

    it "returns 'Follow link' if the ranter is NOT already identified as a person of interest" do
      result = InterestingRanter.build_follow_or_unfollow_link(@seth, @rant_from_non_interesting_ranter)
      expect(result).to include('Follow')
    end


  end

end