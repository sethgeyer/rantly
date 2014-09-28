
feature "user login and logout" do

  before(:each) do
    create_user
    visit_login_page_and_fill_in_form("seth", "password")
  end


  scenario "As a registered user, I can login" do
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_content("Latest Rants")
  end

  scenario "As a registered user, I can't login with incorrect credentials" do
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_css("#new-sessions")
    expect(page).to have_content("Login failed")
    visit_login_page_and_fill_in_form("seth", "")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_css("#new-sessions")
    expect(page).to have_content("Login failed")
  end

  scenario "As a logged in user, I can logout" do
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_content("Latest Rants")
    click_on "Logout"
    expect(page).to have_link("Login")
  end

end