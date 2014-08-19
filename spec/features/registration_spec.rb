require 'rails_helper'

feature "registration page" do
  before(:each) do
    visit "/users/new"
  end
  scenario "visitor visits the registration page" do
    fill_in "Username", with: "sethy"
    fill_in "Password", with: "password"
    fill_in "First name", with: "Seth"
    fill_in "Last name", with: "Geyer"
    fill_in "Bio", with: "Handsome Programmer"
    within(page.find("#new_users")) { choose "Daily" }
    click_on "Register"
    expect(page).to have_css("#home")
    expect(page).to have_content("Thank you for registering sethy!")
  end
end