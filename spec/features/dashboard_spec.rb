feature "Dashboard Page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user, I can link to edit my profile" do
    expect(page).to have_content "Seth Geyer"
    click_on "Seth Geyer"
    expect(page).to have_css("#edit-profile")
  end

  scenario "As a user, I can post my rants" do
    expect(page).to have_css(".rant-form")
  end


  scenario "As a user, I can view my rants" do
    expect(page).to have_css(".my-rants")
    expect(page.find(".my-rants")).to have_content("#{'d' * 141}2")
  end

  scenario "As a user, I can view others rants" do
    expect(page.find(".others-rants")).to have_content("Adam")
    expect(page.find(".others-rants")).to have_link("Follow")
    expect(page.find(".others-rants")).to have_content("#{'d' * 141}1")
    expect(page.find(".others-rants")).not_to have_content("#{'d' * 141}2")

  end

  scenario "As a user, I can click on another user to follow them or 'unfollow' them" do
    expect(page.find(".others-rants")).to have_content("Adam")
    first('.other-details').click_link("Follow")
    expect(page.find(".others-rants")).to have_link("Unfollow")
    click_link("Unfollow")
    expect(page.find(".others-rants")).to have_link("Follow")

  end

  scenario "As a user, I can click on another user's rants to see the show page for the rant" do
    find(".rant-link").click
    expect(page).to have_css("#show-rants")
    expect(page).to have_content("My Pants")
  end

  scenario "As a user, I can click on another user's name to see their profile" do
    find(".profile-link").click
    expect(page).to have_css("#show-users")
    expect(page).to have_content("Adam")
    expect(page).to have_content("Handsome Programmer")

  end

  scenario "As a user, I can link to my favorites from the hoempage" do
    click_on "Favorites"
    expect(page).to have_css("#index-favorites")
  end

  scenario "As a user, I can make a rant a 'favorite" do
    within(".others-rants") { click_on "Favorite" }
    expect(page).to have_css("#show-dashboard")
    click_on "Favorites"
    expect(page).to have_css("#index-favorites")
    expect(page).to have_content("Adam")
    click_on "Dashboard"
    within(".others-rants") { click_on "Unfavorite" }
    expect(page).to have_css("#show-dashboard")
    click_on "Favorites"
    expect(page).to have_css("#index-favorites")
    expect(page).not_to have_content("Adam")
  end

  scenario "As a user, I can link to the search form" do
    click_on "Search"
    expect(page).to have_css("#index-rants")
  end

  scenario "As a user, I can see a 'mentioned section' if I've been mentioned in the details of a rant" do
    expect(page).not_to have_content("Mentioned")
    create_rant(4, {user_id: @user1.id, details: "@#{@user2.username} stinks  #{'d' * 141}4"})
    click_on "Dashboard"
    expect(page).to have_content("Mentioned")
    expect(page.find(".mentioned-rants")).to have_content("@seth stinks")
  end

  scenario "As a user, I can see a 'mentioned section' if I've been mentioned in the topic of a rant" do
    expect(page).not_to have_content("Mentioned")
    create_rant(5, {user_id: @user1.id, topic: "@#{@user2.username} stinks", details: "#{'stinky' * 30}5"    })
    click_on "Dashboard"
    expect(page).to have_content("Mentioned")
    expect(page.find(".mentioned-rants")).to have_content("stinky")
  end




end