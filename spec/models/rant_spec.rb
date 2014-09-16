describe Rant do
  context "Validations" do

    it "requires a title (aka:topic)" do
      rant = Rant.new(topic: "")
      rant.valid?
      expect(rant.errors[:topic]).to include("can't be blank")
      rant.topic = "Rants in Pants"
      rant.valid?
      expect(rant.errors[:topic].any?).to eq(false)
    end

    it "requires a title (aka:topic) to be less than 50 characters" do
      rant = Rant.new(topic: "#{'t' * 50 }")
      rant.valid?
      expect(rant.errors[:topic]).to include("must be less than 50 characters")
      rant.topic = "Rants in Pants"
      rant.valid?
      expect(rant.errors[:topic].any?).to eq(false)
    end


    it "requires a body (aka: details)" do
      rant = Rant.new(details: "")
      rant.valid?
      expect(rant.errors[:details]).to include("can't be blank")
      rant.details = "f" * 141
      rant.valid?
      expect(rant.errors[:details].any?).to eq(false)
    end


    it "requires a body (aka: details) to be at least 140 characters" do
      rant = Rant.new(details: "#{'d' * 140 }")
      rant.valid?
      expect(rant.errors[:details]).to include("must be more than 140 characters")
      rant.details = "d" * 141
      rant.valid?
      expect(rant.errors[:details].any?).to eq(false)
    end
  end

  describe "#sort_by_most_favorited" do
    it "sorts the users rants by most favorited" do
      logged_in_user = create_user(username: "seth")
      other_user = create_user(username: "adam", first_name: "Adam")
      bad_rant = create_rant(1, {topic: "rant1", user_id: other_user.id})
      good_rant = create_rant(2, {topic: "rant2", user_id: other_user.id})
      favorited_item = create_favorite_rant(logged_in_user.id, good_rant.id )
      unsorted_rants = Rant.where(user_id: other_user.id)
      sorted_rants = Rant.sort_by_most_favorited(unsorted_rants)
      expect(sorted_rants.first.topic).to eq("rant2")
    end
  end



end