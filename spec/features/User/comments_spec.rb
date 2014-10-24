feature "create and view comments" do
  before(:each) do
    @adam = create_user_with_a_confirmed_email({first_name: "Adam", username: "adam"})
    @rant_to_visit = create_rant(1, {user_id: @adam.id})
    @seth = create_user_with_a_confirmed_email({username: "seth"})
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As a user visiting a rant show page, I should see a comment form" do
    visit rant_path(@rant_to_visit.id)
    expect(page).to have_css("#new_rant_comment")
    fill_in "rant_comment[body]", with: "This post rules"
    click_on "Rant Back"
    expect(page).to have_button("Rant Back")
    expect(page).to have_content("This post rules")
  end


  scenario "As a user visiting a users profile page, I should be able to comment" do
    visit profile_path(@adam)
    expect(page).to have_css(".new_user_comment")
    fill_in "user_comment[body]", with: "This profile rules"
    click_on "Rant Back"
    expect(page).to have_button("Rant Back")
    expect(page).to have_content("This profile rules")
  end



end
