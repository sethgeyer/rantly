require 'rails_helper'

feature "Home Page" do
  scenario "As a user, I can access the regsitration page, via the link" do
    visit "/"
    click_on("Join")
    expect(page).to have_css("#new_users")
  end
end