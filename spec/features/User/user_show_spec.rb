feature "User Profile Page" do
  before(:each) do
    @adam = create_user_with_a_confirmed_email({first_name: "Adam", username: "adam"})
    @adam_rant1 = create_rant(1, {user_id: @adam.id})
    @adam_rant3 = create_rant(3, {user_id: @adam.id})
    @seth = create_user_with_a_confirmed_email
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "A user's show page should include all of their individual rants in addition to their bio" do
    visit profile_path(@adam.id)
    expect(page).to have_content("Adam")
    expect(page).to have_content("Handsome Programmer")
    expect(page).to have_content("#{'d' * 141}1")
    expect(page).to have_content("#{'d' * 141}3")
  end

  scenario "A user can choose to follow an interesting ranter from the interesting ranter's profile page.", js: true do
    visit profile_path(@adam.id)
    expect(page).to have_content("Adam")
    find(".follower").click
    # expect(page).to have_link "Unfollow"
    find(".unfollower").click
    expect(page).to have_css(".follower")
  end

  scenario "A user can see another user's rant, organized by most favorited" do
    create_favorite_rant(@seth.id, @adam_rant3.id)
    visit profile_path(@adam.id)
    expect(first(".rant")).to have_content("My Pants #3")
  end

  scenario "As a user, I can click on another user's rants to see the show page for the rant" do
    visit profile_path(@adam.id)
    first(".rant-link").click
    expect(page).to have_css(".rants")
    expect(page).to have_content("My Pants")
  end


end