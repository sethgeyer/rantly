feature "Dashboard Page" do
  before(:each) do
    @adam = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @adam.id})
    @seth = create_user({username: "seth"})
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user, I can link to edit my profile" do
    click_on "Seth Geyer"
    expect(page).to have_content("Edit Profile")
  end

  scenario "As a user, I can post my rants" do
    expect(page).to have_css(".rant-form")
  end

  scenario "As a user, I can view my rants" do
    expect(page.first(".my-rants")).to have_content("#{'d' * 141}2")
  end

  scenario "As a user, I can view others'rants" do
    expect(page.find(".others-rants")).to have_content("Adam")
    expect(page.find(".others-rants")).to have_content("#{'d' * 141}1")
    expect(page.find(".others-rants")).not_to have_content("#{'d' * 141}2")
  end

  scenario "As a user, I can chose to 'follow' or 'unfollow' another user", js: true do
    expect(page.find(".others-rants")).to have_content("Adam")
    first('.fifteen-wide .follower').click
    first('.fifteen-wide .unfollower').click
    expect(page.find(".others-rants")).to have_css(".follower")
  end

  scenario "As a user, I can click on another user's rants to see the show page for the rant" do
    first(".rant-link").click
    expect(page).to have_content("My Pants")
  end

  scenario "As a user, I can click on another user's name to see their profile" do
    first(".fifteen-wide > .profile-link").click
    expect(page).to have_css(".rants")
    expect(page).to have_content("Adam")
    expect(page).to have_content("Handsome Programmer")

  end

  scenario "As a user, I can link to my favorites from the hoempage" do
    click_on "Favorites"
    expect(page).to have_content("Favorites")
  end

  scenario "As a user, I can make a rant a 'favorite", js: true do
    first(".favoriter").click
    expect(page).to have_content("Latest Rants")
    click_on "Favorites"
    expect(page).to have_content("Favorites")
    expect(page).to have_content("Adam")
    click_on "Dashboard"
    first(".unfavoriter").click

    expect(page).to have_content("Latest Rants")
    click_on "Favorites"
    expect(page).to have_content("Favorites")
    expect(page).not_to have_content("Adam")
  end


  scenario "As a user, I can see how many people have favorited a rant", js: true do
    first(".favoriter").click
    find(".unfavoriter").click
     expect(page).to have_content("Favorite")

  end




  scenario "As a user, I can link to the search form" do
    click_on "Search"
    expect(page).to have_css(".horizontal-form-input")
  end

  scenario "As a user, I can see a 'mentioned section' if I've been mentioned in the details of a rant" do
    expect(page).not_to have_content("Mentioned")
    create_rant(4, {user_id: @adam.id, details: "@#{@seth.username} stinks  #{'d' * 141}4"})
    click_on "Dashboard"
    expect(page).to have_content("Mentioned")
    expect(page.first(".mentioned-rants")).to have_content("@seth stinks")
  end

  scenario "As a user, I can see a 'mentioned section' if I've been mentioned in the topic of a rant" do
    expect(page).not_to have_content("Mentioned")
    create_rant(5, {user_id: @adam.id, topic: "@#{@seth.username} stinks", details: "#{'stinky' * 30}5"    })
    click_on "Dashboard"
    expect(page).to have_content("Mentioned")
    expect(page.first(".mentioned-rants")).to have_content("stinky")
  end

end