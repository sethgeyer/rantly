feature "followers_page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    create_interesting_ranter(user_id: @user2.id, person_id: @user1.id)
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
    click_on "Following"
  end

  scenario "A user can see the ranters they're following and won't see the ranters they're not following" do
    expect(page).to have_content("Adam")
    click_on "Unfollow"
    expect(page).not_to have_content("Adam")
  end









end