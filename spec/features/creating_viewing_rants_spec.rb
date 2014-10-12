feature "create and view rants" do

  before(:each) do
    # User.destroy_all
    # Rant.destroy_all
    # Favorite.destroy_all
    @user = create_user
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user, I can create a rant" do
    fill_in "A rant about", with: "My Pants"
    fill_in "Rant", with: "#{'d' * 141}"
    click_on "Rant"
    expect(page).to have_content("Latest Rants")
    expect(page.first(".my-rants")).to have_content("#{'d' * 141}")
  end

  scenario "As a user, I can not create a rant without complete information" do
    fill_in "A rant about", with: ""
    fill_in "Rant", with: "I've got rants in my pants."
    click_on "Rant"
    expect(page).to have_content("Latest Rants")
    expect(page.find(".rant-form")).to have_content("can't be blank")
  end

  scenario "As a user, I can delete a rant" do
    create_rant(1, {user_id: @user.id})
    click_on "Dashboard"
    expect(page.first(".my-rants")).to have_content("#{'d' * 141}1")
    click_on "Delete"
    expect(page).to have_content("Latest Rants")
    expect(page).not_to have_content("#{'d' * 141}1")
  end


  context "As a user viewing a specific rant" do
    before(:each) do
      @adam = create_user({first_name: "Adam", username: "adam"})
      @rant = create_rant(2, {user_id: @adam.id})
      visit rant_path(@rant.id)
    end

    scenario "As a user, if I'm viewing a specific rant, I can click on the user's name to view their profile" do
      find(".shown-rant .profile-link").click
      expect(page).to have_css(".rants")
      expect(page).to have_content("Adam")
      expect(page).to have_content("Handsome Programmer")
    end

    scenario "As a user, if I'm viewing a specific rant, I can make a rant a 'favorite", js: true  do

      # within(".rants") { click_on "Favorite" }
      find(".favoriter").click
      expect(page).to have_css(".rants")
      click_on "Favorites"
      expect(page).to have_content("Favorites")
      expect(page).to have_content("Adam")
      visit rant_path(@rant.id)
      find(".unfavoriter").click
      expect(page).to have_css(".rants")
      click_on "Favorites"
      expect(page).to have_content("Favorites")
      expect(page).not_to have_content("Adam")
    end
  end

end