feature "Admin Rants" do

  before(:each) do
    user = create_user({first_name: "Seth", last_name: "Geyer"})
    @first_rant = create_rant(3, {topic: "first_rant_created", user_id: user.id})
    @second_rant = create_rant(1, {topic: "second_rant_created", user_id: user.id})
    @third_rant = create_rant(2, {topic: "third_rant_created", user_id: user.id})

    create_admin_user
    visit_login_page_and_fill_in_form("admin", "password")
    within("#new-sessions") {click_on "Login"}
  end

  scenario "As an admin, I can view a list of all rants in the system ordered by date" do
    click_on "Rants"
    expect(page).to have_content("third_rant_created")
    expect(page).to have_content("Seth Geyer")
  end



end