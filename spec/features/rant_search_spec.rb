feature "search rants" do
  before(:each) do
    @user1 = create_user({first_name: "Steve", username: "steve", last_name: "Smith"})
    @rant1 = create_rant(1, {user_id: @user1.id})
    @rant3 = create_rant(3, {user_id: @user1.id})
    @user3 = create_user({first_name: "Steve", username: "ssteve", last_name: "Steve"})
    @rant4 = create_rant(4, {user_id: @user3.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
    visit rants_path
  end

  scenario "As a user, I should be able to search rants by the user's last name" do
    fill_in "search", with: "Smith"
    within("#index-rants") { click_on "Search" }
    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
  end

  scenario "As a user, I should be able to search rants by the user's first name" do
    fill_in "search", with: "Steve"
    within("#index-rants") { click_on "Search" }
    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
    expect(page).to have_content("My Pants #4")

  end

  scenario "As a user, I should be able to search rants by the user's username" do
    fill_in "search", with: "steve"
    within("#index-rants") { click_on "Search" }
    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")


  end


end