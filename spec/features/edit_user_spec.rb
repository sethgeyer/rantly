
feature "Edit User Details" do

  scenario "As a user, I can edit my user details" do
    create_user
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
    visit edit_user_path
    expect(page.find_field("Username").value).to eq("seth")
    expect(page.find_field("Last name").value).to eq("Geyer")
    expect(page.find_field("First name").value).to eq("Seth")
    fill_in "First name", with: "Sethy"
    fill_in "Last name", with: "Geyery"
    fill_in "Username", with: "sethy"
    fill_in "Password", with: "passwordy"
    fill_in "Bio", with: "Handsome Programmery"
    choose "Weekly"
    click_on "Update"
    expect(page).to have_content("Latest Rants")
    expect(page).to have_link("Sethy Geyery")
  end

end