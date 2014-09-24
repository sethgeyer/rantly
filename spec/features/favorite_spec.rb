feature "Favorites Page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end



  scenario "As a user, I can link to my favorites from the hoempage" do
    click_on "Favorites"
    expect(page).to have_content("Favorites")
  end

  scenario "As a user, I can unfavorite a rant on the favorite page" do
    within(".others-rants") { click_on "Favorite" }
    expect(page).to have_content("Others Rants")
    click_on "Favorites"
    expect(page).to have_content("Favorites")
    expect(page).to have_content("Adam")
    expect(page).to have_link("Unfavorite")
    click_on "Unfavorite"
    expect(page).not_to have_content("Adam")
  end



end