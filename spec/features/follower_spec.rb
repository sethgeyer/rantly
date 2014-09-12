feature "followers_page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user({first_name: "Leah", username: "leah"})
    create_rant(2, {user_id: @user2.id})
    @user3 = create_user
    create_rant(3, {user_id: @user3.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
  end

  scenario "A user can see the ranters they're following and won't see the ranters they're not following" do
    expect(page.find(".others-rants")).to have_content("Adam")
    first('.other-details').click_link("Follow")
    click_on "Following"
    expect(page).to have_css("#index-interesting_ranters")
    expect(page).to have_content("Adam")
    click_on "Dashboard"
    expect(page.find(".others-rants")).to have_content("Adam")
    first('.other-details').click_link("Unfollow")
    click_on "Following"
    expect(page).to have_css("#index-interesting_ranters")
    expect(page).not_to have_content("Adam")


  end
end