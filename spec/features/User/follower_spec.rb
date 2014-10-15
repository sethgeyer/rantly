feature "followers_page" do

  before(:each) do
    @adam = create_user_with_a_confirmed_email({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @adam.id})
    @seth = create_user_with_a_confirmed_email
    create_rant(2, {user_id: @seth.id})
    create_interesting_ranter(user_id: @seth.id, person_id: @adam.id)
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
    click_on "Following"
  end

  scenario "A user can see the ranters they're following and won't see the ranters they're not following", js: true do
    expect(page).to have_content("Adam")
    find(".unfollower").click
    expect(page).not_to have_content("Adam")
  end

end