
feature "user login and logout" do

  scenario "As a registered user, I can login" do
    create_user
    visit_login_page_and_fill_in_form("seth", "password")
    click_on "Login"
    expect(page).to have_css("#show-dashboard")
  end

  scenario "As a logged in user, I can logout" do
    create_user
    visit_login_page_and_fill_in_form("seth", "password")
    click_on "Login"
    expect(page).to have_css("#show-dashboard")
    click_on "Logout"
    expect(page).to have_link("Login")
  end






end