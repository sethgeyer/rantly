feature "rant" do
  before(:each) do
    @user = create_user
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
  end

  scenario "As a user, I can create a rant" do
    fill_in "A rant about", with: "My Pants"
    fill_in "Rant", with: "I've got rants in my pants."
    click_on "Rant"
    expect(page).to have_css("#show-dashboard")
    expect(page.find(".my-rants")).to have_content("I've got rants in my pants.")
  end


  scenario "As a user, I can delete a rant" do
    create_rant(1, {user_id: @user.id})
    click_on "Dashboard"
    expect(page.find(".my-rants")).to have_content("I've got rants in my pants #1")
    click_on "Delete"
    expect(page).to have_css("#show-dashboard")
    expect(page.find(".my-rants")).not_to have_content("I've got rants in my pants #1")

  end


end