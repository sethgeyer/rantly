feature "Admin Rights" do

  before(:each) do
    user = create_user({first_name: "Seth", last_name: "Geyer"})
    @first_rant = create_rant(3, {topic: "first_rant_created", user_id: user.id})
    @second_rant = create_rant(1, {topic: "second_rant_created", user_id: user.id})
    @third_rant = create_rant(2, {topic: "third_rant_created", user_id: user.id})
  end


  scenario "As a non-admin, I can not access the 'admin's view' of rants" do
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    visit admin_rants_path
    expect(page).to have_content("Let It All Out")
  end


  scenario "As a non-admin, I can not access the 'admin's view' of users" do
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    visit admin_users_path
    expect(page).to have_content("Let It All Out")
  end

  context "As a logged in admin" do
    before(:each) do
      create_admin_user
      visit_login_page_and_fill_in_form("admin", "password")
      within("#new-sessions") {click_on "Login"}
    end

    scenario "As an admin, I can view a list of all rants in the system ordered by date" do
      click_on "Rants"
      expect(page).to have_content("third_rant_created")
      expect(page).to have_content("Seth Geyer")
    end

    scenario "As an admin, I can view a list of all users and their total rants" do
      click_on "Users"
      expect(page).to have_content("Seth Geyer")
      expect(page).to have_content("3")
      expect(page).to have_content("Ad Min")

    end

  end






end