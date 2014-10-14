describe User do
  context "Validations" do

    it "requires a user's email" do
      user = User.new(email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
      user.email = "seth.geyer@gmail.com"
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end


    it "requires a user's first name" do
      user = User.new(first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
      user.first_name = "Seth"
      user.valid?
      expect(user.errors[:first_name].any?).to eq(false)
    end

    it "requires a user's last name" do
      user = User.new(last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
      user.last_name = "Geyer"
      user.valid?
      expect(user.errors[:last_name].any?).to eq(false)
    end

    it "requires a user's username" do
      user = User.new(username: "")
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
      user.username = "sethgeyer"
      user.valid?
      expect(user.errors[:username].any?).to eq(false)
    end

    it "requires a user's username to be unique" do
      existing_user = User.create(
        first_name: "Seth",
        last_name: "Geyer",
        username: "seth",
        password: "password",
        email: "seth.geyer@gmail.com",
        bio: "handsome programmer",
        rant_frequency: "daily",
        image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg"
      )
      expect(existing_user.valid?).to eq(true)
      user = User.new(username: "seth")
      user.valid?
      expect(user.errors[:username]).to include("has already been taken")
      user.username = "sethy"
      user.valid?
      expect(user.errors[:username].any?).to eq(false)
    end

    it "requires the user's password to be a minimum of 8 characters" do
      user = User.new(password: "pword")
      user.valid?
      expect(user.errors[:password]).to include("must be 8 characters in length")
      user.password = "password"
      user.valid?
      expect(user.errors[:password].any?).to eq(false)
    end


    it "requires a user's bio" do
      user = User.new(bio: "")
      user.valid?
      expect(user.errors[:bio]).to include("can't be blank")
      user.bio = "handsome programmer"
      user.valid?
      expect(user.errors[:bio].any?).to eq(false)
    end

    it "requires a user to chose a rant frequency" do
      user = User.new(rant_frequency: "")
      user.valid?
      expect(user.errors[:rant_frequency]).to include("can't be blank")
      user.rant_frequency = "handsome programmer"
      user.valid?
      expect(user.errors[:rant_frequency].any?).to eq(false)
    end

    it "requires a user's image" do
      user = User.new(image: "")
      user.valid?
      expect(user.errors[:image]).to include("can't be blank")
      user.image = "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg"
      user.valid?
      expect(user.errors[:image].any?).to eq(false)
    end



  end

end