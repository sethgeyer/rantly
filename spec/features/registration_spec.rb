require 'rails_helper'

feature "user registration" do
  before(:each) do
    visit "/users/new"
  end
  scenario "As a visitor that fills in the registration page completely, I can successfully register" do
    fill_in "First name", with: "Seth"
    fill_in "Last name", with: "Geyer"
    fill_in "Username", with: "sethy"
    fill_in "Password", with: "password"
    fill_in "Bio", with: "Handsome Programmer"
    within(page.find("#new-users")) { choose "Daily" }
    click_on "Register"
    expect(page).to have_css("#home")
    expect(page).to have_content("Thank you for registering sethy!")
  end
end