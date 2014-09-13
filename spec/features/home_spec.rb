
feature "Home Page" do
  before(:each) do
    visit "/"
  end

  scenario "A a visitor, the homepage includes a splash page and links/buttons to login/join" do
    expect(page).to have_css("#home")
    expect(page).to have_content("Let It All Out")
    expect(page).to have_link("Login")
    expect(page).to have_link("Join")
  end

  scenario "As a visitor, I can access the regsitration page, via the link" do
    click_on("Join")
    expect(page).to have_css("#new-users")
  end

  scenario "As a visitor, I can access the login page, via the link" do
    click_on("Login")
    expect(page).to have_css("#new-sessions")
  end

  context "As a successfully logged in user" do

    before(:each) do
      create_user
      visit_login_page_and_fill_in_form("seth", "password")
      click_on "Login"
    end

    scenario "I can logout" do
      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Join")
      expect(page).to have_link("Logout")
    end

    scenario "I can see a dashboard link" do
      expect(page).to have_link "Dashboard"
    end





  end



end