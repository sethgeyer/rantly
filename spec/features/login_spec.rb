require 'rails_helper'


feature "user login" do
  scenario "As a registered user, I can login" do
    create_user
    visit "/sessions/new"
    expect(page).to have_css("#new-sessions")
    fill_in "Username", with: 'seth'
    fill_in "Password", with: 'password'
    click_on "Login"
    expect(page).to have_css("#home")
    expect(page).to have_content("Welcome Seth Geyer")

  end
end