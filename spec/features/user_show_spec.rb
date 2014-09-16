feature "User Show Page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    create_rant(3, {user_id: @user1.id})

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


  scenario "A user's show page should include all of their individual rants in addition to their bio" do
    visit "/users/#{@user1.id}"
    expect(page).to have_content("Adam")
    expect(page).to have_content("Handsome Programmer")
    expect(page).to have_content("#{'d' * 141}1")
    expect(page).to have_content("#{'d' * 141}3")
  end

  scenario "A user can choose to follow an interesting ranter from the interesting ranter's profile page." do
    visit "/users/#{@user1.id}"
    expect(page).to have_content("Adam")
    expect(page).to have_link "Follow"
    click_on "Follow"
    expect(page).to have_link "Unfollow"
    click_on "Unfollow"
    expect(page).to have_link "Follow"
  end

end