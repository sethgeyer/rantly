feature "Dashboard Page" do
  before(:each) do
    create_user
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
  end

  scenario "As a user, I can link to edit my profile" do
    expect(page).to have_content "Seth Geyer"
    click_on "Seth Geyer"
    expect(page).to have_css("#edit-profile")
  end

  scenario "As a user, I can post my rants" do
    expect(page).to have_css(".rants-form")
  end



end