feature "create and view comments" do
  before(:each) do
    @adam = create_user({first_name: "Adam", username: "adam"})
    @rant_to_visit = create_rant(1, {user_id: @adam.id})
    @seth = create_user({username: "seth"})
    create_rant(2, {user_id: @seth.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    within("#new-sessions") {click_on "Login"}
    visit rant_path(@rant_to_visit.id)
  end

  scenario "As a user visiting a rant show page, I should see a comment form" do
    expect(page).to have_css("#new_comment")
    fill_in "comment[body]", with: "This post rules"
    click_on "Rant Back"
    expect(page).to have_button("Rant Back")
    expect(page).to have_content("This post rules")

  end

end
