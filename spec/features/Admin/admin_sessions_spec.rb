feature "Impersonate" do

  before(:each) do
    @adam = create_user_with_a_confirmed_email({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @adam.id})
    create_rant(2, {user_id: @adam.id})
    create_admin_user
    visit_login_page_and_fill_in_form('admin', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As an admin I can login and logout as an impersonated user" do
    click_on "Impersonate"
    fill_in "Username", with: "adam"
    click_on "Login"
    expect(page).to have_button("Logout as Impersonator")
    first(".profile-link").click
    expect(page).to have_content("Edit Profile")
    click_on "Logout"
    expect(page).to have_content("Rants per Day")
  end


end