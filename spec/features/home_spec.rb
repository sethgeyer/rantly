require 'rails_helper'

feature "Home Page" do
  before(:each) do
    visit "/"
  end

  scenario "A a visitor, the homepage includes a splash page with banner and quotes" do
    expect(page).to have_css("#home")
    expect(page).to have_content("Let It All Out")
  end

  scenario "As a visitor, I can access the regsitration page, via the link" do
    click_on("Join")
    expect(page).to have_css("#new-users")
  end

  scenario "As a visitor, I can access the login page, via the link" do
    click_on("Login")
    expect(page).to have_css("#new-sessions")
  end


end