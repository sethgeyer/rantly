describe Favorite do

  describe "#create_favorite_link_text" do
    before(:each) do

      Favorite.create!(rant_id: 1, user_id: 1)
      Favorite.create!(rant_id: 1, user_id: 3)
      @rant_id = 1
      @non_favorited_rant = 5

    end

    it "creates the text for the favorites/unfavorite link that includes a count if other people have favorited the rant" do
      fave_count = Favorite.create_favorite_count(@rant_id)
      expect(fave_count).to eq("2-")
    end

    it "does not create additional text if other people have not favorited the account" do
      fave_count = Favorite.create_favorite_count(@non_favorited_rant)
      expect(fave_count).to eq(nil)
    end



  end

end