feature "Favorites Page" do

  before(:each) do
    @adam = create_user_with_a_confirmed_email({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @adam.id})
    @seth = create_user_with_a_confirmed_email
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user, I can link to my favorites from the hoempage" do
    click_on "Favorites"
    expect(page).to have_content("Favorites")

  end

  scenario "As a user, I can unfavorite a rant on the favorite page", js: true do
    first(".favoriter").click

    expect(page).to have_content("Latest Rants")
    click_on "Favorites"
    expect(page).to have_content("Favorites")
    expect(page).to have_content("Adam")
    expect(page).to have_css(".unfavoriter")
    first(".unfavoriter").click
    expect(page).not_to have_content("Adam")
  end

  scenario "As a user, I can click on another user's rants from the favorites page to see the show page for the rant", js: true do
    first(".favoriter").click
    click_on "Favorites"
    first(".rant-link").click
    expect(page).to have_css(".rants")
    expect(page).to have_content("My Pants")
  end


end