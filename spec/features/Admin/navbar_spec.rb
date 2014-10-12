feature "Admin Navbar" do

  before(:each) do
    create_user({username: "admin", password: "password", first_name: "Ad", last_name: "Min", is_admin: true})
    visit_login_page_and_fill_in_form("admin", "password")
    within("#new-sessions") {click_on "Login"}
  end


  scenario "As an admin, my navbar should include admin-specific navigation tools" do
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("Rants")
    expect(page).to have_content("Users")
    expect(page).not_to have_content("Favorites")
    expect(page).not_to have_content("Following")

  end



end