feature "Favorites Page" do

  before(:each) do
    @adam = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @adam.id})
    @seth = create_user
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user, I can link to my favorites from the hoempage" do
    click_on "Favorites"
    expect(page).to have_content("Favorites")

  end

  scenario "As a user, I can unfavorite a rant on the favorite page" do
    within(".others-rants") { click_on "Favorite" }
    expect(page).to have_content("Latest Rants")
    click_on "Favorites"
    expect(page).to have_content("Favorites")
    expect(page).to have_content("Adam")
    expect(page).to have_link("Unfavorite")
    click_on "Unfavorite"
    expect(page).not_to have_content("Adam")
  end

  scenario "As a user, I can click on another user's rants from the favorites page to see the show page for the rant" do
    within(".others-rants") { click_on "Favorite" }
    click_on "Favorites"
    first(".rant-link").click
    expect(page).to have_css(".rants")
    expect(page).to have_content("My Pants")
  end


end