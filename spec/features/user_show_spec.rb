feature "User Show Page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
  end

  scenario "As a user I can visit another user's show page" do
    visit "/users/#{@user1.id}"
    expect(page).to have_content("Adam")
    expect(page).to have_content("Handsome Programmer")
  end



end