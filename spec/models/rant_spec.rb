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

  context "Collecting and Organizing Rants" do
    before(:each) do
      @logged_in_user = create_user(username: "seth")
      @other_user = create_user(username: "adam", first_name: "Adam")
      bad_rant = create_rant(1, {topic: "rant1", user_id: @other_user.id})
      @good_rant = create_rant(2, {topic: "rant2", user_id: @other_user.id})
      favorited_item = create_favorite_rant(@logged_in_user.id, @good_rant.id)
    end

    describe "#sort_by_most_favorited" do
      it "sorts the users rants by most favorited" do
        unsorted_rants = Rant.where(user_id: @other_user.id)
        sorted_rants = Rant.sort_by_most_favorited(unsorted_rants)
        expect(sorted_rants.first.topic).to eq("rant2")
      end
    end

    describe "#return results for search" do
      it "returns a list of search results if a search term was submitted" do
        returned_rants = Rant.return_results_for_search("d")
        expect(returned_rants.count).to eq(2)
      end

      it "returns an empty array if no values found" do
        returned_rants = Rant.return_results_for_search("z")
        expect(returned_rants.count).to eq(0)
      end

      it "returns nil if no search value provided" do
        returned_rants = Rant.return_results_for_search(nil)
        expect(returned_rants).to eq(nil)
      end
    end
  end

  describe "#shorten_it" do
    it "returns a shorterned version of a rant if the rant has more than 300 words" do
      rant = Rant.create!(topic: "Long Cupcake Rant", details: "Cupcake ipsum dolor sit amet marzipan. Pie ice cream lemon drops tiramisu marshmallow. Danish candy carrot cake bear claw. Tart jelly beans icing. Pudding dragée halvah muffin gummies tiramisu donut unerdwear.com bear claw. Jelly-o wafer bear claw brownie chocolate bonbon. Applicake cheesecake candthis_is_the_300th_word canes biscuit. Carrot cake muffin ice cream sesame snaps apple pie. Jelly beans biscuit lollipop dragée tootsie roll bear claw sesame snaps sweet roll. Jelly pudding marshmallow gummies chocolate. Chocolate macaroon gummi bears cake cupcake. Cotton candy muffin jelly beans pie wafer liquorice gingerbread cake. Ice cream bonbon cake.Cupcake ipsum dolor sit amet marzipan. Pie ice cream lemon drops tiramisu marshmallow. Danish candy carrot cake bear claw. Tart jelly beans icing. Pudding dragée halvah muffin gummies tiramisu donut unerdwear.com bear claw. Jelly-o wafer bear claw brownie chocolate bonbon. Applicake cheesecake candy canes biscuit. Carrot cake muffin ice cream sesame snaps apple pie. Jelly beans biscuit lollipop dragée tootsie roll bear claw sesame snaps sweet roll. Jelly pudding marshmallow gummies chocolate. Chocolate macaroon gummi bears cake cupcake. Cotton candy muffin jelly beans pie wafer liquorice gingerbread cake. Ice cream bonbon cake.Cupcake ipsum dolor sit amet marzipan. Pie ice cream lemon drops tiramisu marshmallow. Danish candy carrot cake bear claw. Tart jelly beans icing. Pudding dragée halvah muffin gummies tiramisu donut unerdwear.com bear claw. Jelly-o wafer bear claw brownie chocolate bonbon. Applicake cheesecake candy canes biscuit. Carrot cake muffin ice cream sesame snaps apple pie. Jelly beans biscuit lollipop dragée tootsie roll bear claw sesame snaps sweet roll. Jelly pudding marshmallow gummies chocolate. Chocolate macaroon gummi bears cake cupcake. Cotton candy muffin jelly beans pie wafer liquorice gingerbread cake. Ice cream bonbon cake Danish candy carrot cake bear claw. Tart jelly beans icing. Pudding dragée halvah muffin gummies tiramisu donut unerdwear.com bear claw. Jelly-o wafer bear claw brownie this-is-the-300th-word bonbon. Applicake cheesecake candy canes biscuit. Carrot cake muffin ice cream sesame snaps apple pie. Jelly beans biscuit lollipop dragée tootsie roll bear claw sesame snaps sweet roll. Jelly pudding marshmallow gummies chocolate. Chocolate macaroon gummi bears cake cupcake.")
      shortened_rant = rant.shorten_it
      expect(shortened_rant.split(" ").last).to eq("this-is-the-300th-word...")
    end
    it "returns the full rant if the rant has less than 300 words" do
      rant = Rant.create!(topic: "Short Cupcake Rant", details: "#{'d' * 141} last-word-of-full-rant.")
      shortened_rant = rant.shorten_it
      expect(shortened_rant.split(" ").last).to eq("last-word-of-full-rant.")
    end


  end

end