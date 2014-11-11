
feature "user login and logout" do

  scenario "As a registered user, I can NOT succesfully login until I have confirmed my email" do
    visit new_user_path
    fill_in "First name", with: "Seth"
    fill_in "Last name", with: "Geyer"
    fill_in "Username", with: "seth"
    fill_in "Password", with: "password"
    fill_in "Bio", with: "Handsome Programmer"
    fill_in "Email", with: "seth.geyer@gmail.com"
    find("#user_image").click
    within(page.find("#new-users")) { choose "Daily" }
    click_on "Register"
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_content("You must confirm your email prior to logging in.")
  end


  scenario "As a registered user, I can login" do
    visit new_user_path
    fill_in "First name", with: "Seth"
    fill_in "Last name", with: "Geyer"
    fill_in "Username", with: "seth"
    fill_in "Password", with: "password"
    fill_in "Bio", with: "Handsome Programmer"
    fill_in "Email", with: "seth.geyer@gmail.com"
    find("#user_image").click
    within(page.find("#new-users")) { choose "Daily" }
    click_on "Register"
    visit email_confirmation_path(EmailConfirmer.find_by_user_id(User.last.id).confirmation_token)
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_content("Latest Rants")
  end


  scenario "As a registered user, I can't login with incorrect credentials" do
    create_user_with_a_confirmed_email
    visit_login_page_and_fill_in_form("", "password")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_css("#new-sessions")
    expect(page).to have_content("Login failed")
    visit_login_page_and_fill_in_form("seth", "")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_css("#new-sessions")
    expect(page).to have_content("Login failed")

  end

  scenario "As a logged in user, I can logout" do
    create_user_with_a_confirmed_email
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    expect(page).to have_content("Latest Rants")
    click_on "Logout"
    expect(page).to have_link("Login")
  end






end