feature "search rants" do
  before(:each) do
    @adam = create_user({first_name: "Steve", username: "steve", last_name: "Smith"})
    @adam_rant1 = create_rant(1, {user_id: @adam.id})
    @adam_rant3 = create_rant(3, {user_id: @adam.id})
    @steve = create_user({first_name: "Steve", username: "ssteve", last_name: "Steve"})
    @steve_rant4 = create_rant(4, {user_id: @steve.id})
    @seth = create_user
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
    visit rants_path
  end


  scenario "As a user, when I visit the search page no rants should be shown until I've searched for something" do
    visit rants_path
    expect(page).not_to have_content("Steve")
  end

  scenario "As a user, I should be able to search rants by the user's last name" do
    fill_in "search", with: "Smith"
    within(".horizontal-form") { click_on "Search" }

    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
  end

  scenario "As a user, I should be able to search rants by the user's first name" do
    fill_in "search", with: "Steve"
    within(".horizontal-form") { click_on "Search" }

    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
    expect(page).to have_content("My Pants #4")

  end

  scenario "As a user, I should be able to search rants by the user's username" do
    fill_in "search", with: "steve"
    within(".horizontal-form") { click_on "Search" }

    expect(page).to have_content("My Pants #1")

    expect(page).to have_content("My Pants #3")
  end

  scenario "As a user, I should be able to search rants by the rants topic" do
    fill_in "search", with: "Pants"
    within(".horizontal-form") { click_on "Search" }
    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
    expect(page).to have_content("My Pants #4")
  end

  scenario "As a user, I should be able to search rants by the rants topic" do
    fill_in "search", with: "ddd"
    within(".horizontal-form") { click_on "Search" }
    expect(page).to have_content("My Pants #1")
    expect(page).to have_content("My Pants #3")
    expect(page).to have_content("My Pants #4")
  end




end