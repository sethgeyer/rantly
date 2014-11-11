
feature "user registration" do

  before(:each) do
    visit new_user_path
    fill_in "First name", with: "Seth"
    fill_in "Last name", with: "Geyer"
    fill_in "Username", with: "seth"
    fill_in "Password", with: "password"
    fill_in "Bio", with: "Handsome Programmer"
    fill_in "Email", with: "seth.geyer@gmail.com"
    find("#user_image").click
    within(page.find("#new-users")) { choose "Daily" }

  end

  scenario "As a visitor that fills in the registration page completely, I can successfully register" do
    click_on "Register"
    expect(page).to have_css("#home")
    expect(page).to have_content("Thank you for registering seth!")
  end

  scenario "As a visitor I see error messages if the form is not completed appropriately" do
    fill_in "First name", with: ""
    click_on "Register"
    expect(page).to have_css("#new-users")
    expect(page).to have_content("First name can't be blank")
  end




end